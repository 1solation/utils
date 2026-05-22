#!/usr/bin/env python3
import subprocess
import re
import urllib.request
import urllib.error
import json
from datetime import datetime, timezone, timedelta
import sys

# --- Configuration ---
MIN_AGE_DAYS = 14
NOW = datetime.now(timezone.utc)
EXIT_CODE = 0

def log_error(msg):
    global EXIT_CODE
    print(f"❌ ERROR: {msg}")
    EXIT_CODE = 1

def log_success(msg):
    print(f"✅ OK: {msg}")

def log_info(msg):
    print(f"ℹ️ {msg}")

def get_staged_diff():
    """Gets the diff of currently staged files."""
    try:
        return subprocess.check_output(['git', 'diff', '--cached']).decode('utf-8')
    except subprocess.CalledProcessError:
        return ""

def clean_version(version_str):
    """Strips npm prefixes like ^, ~, >, =, etc."""
    return re.sub(r'^[^\d]+', '', version_str)

def get_publish_date_npm(pkg, version):
    url = f"https://registry.npmjs.org/{pkg}"
    try:
        req = urllib.request.urlopen(url)
        data = json.loads(req.read())
        date_str = data.get('time', {}).get(version)
        return date_str
    except Exception:
        return None

def get_publish_date_pypi(pkg, version):
    url = f"https://pypi.org/pypi/{pkg}/{version}/json"
    try:
        req = urllib.request.urlopen(url)
        data = json.loads(req.read())
        # PyPI returns an array of files; check the first one
        urls = data.get('urls', [])
        if urls:
            return urls[0].get('upload_time')
    except Exception:
        return None

def get_publish_date_nuget(pkg, version):
    # NuGet requires lowercase for package id and version in this endpoint
    url = f"https://api.nuget.org/v3/registration5-semver1/{pkg.lower()}/{version.lower()}.json"
    try:
        req = urllib.request.urlopen(url)
        data = json.loads(req.read())
        return data.get('published')
    except urllib.error.HTTPError as e:
        # Sometimes semantic versions differ slightly in the URL, fallback is needed in complex setups
        return None
    except Exception:
        return None

def check_quarantine(ecosystem, pkg, version, date_str):
    if not date_str:
        log_error(f"[{ecosystem}] {pkg}@{version} - Could not find publish date on registry. Verify version exists.")
        return

    # Extract just the YYYY-MM-DD part to avoid complex timezone/microsecond parsing issues
    try:
        publish_date = datetime.strptime(date_str[:10], "%Y-%m-%d").replace(tzinfo=timezone.utc)
        age = (NOW - publish_date).days

        if age < MIN_AGE_DAYS:
            log_error(f"[{ecosystem}] {pkg}@{version} is only {age} days old (Published: {date_str[:10]}). Minimum required is {MIN_AGE_DAYS} days.")
        else:
            log_success(f"[{ecosystem}] {pkg}@{version} is {age} days old.")
    except Exception as e:
        log_error(f"[{ecosystem}] {pkg}@{version} - Failed to parse date string '{date_str}': {e}")

def main():
    diff = get_staged_diff()
    if not diff:
        sys.exit(0)

    # Simple regexes to catch additions (+) in diffs, ignoring lines that are part of git's +++ header
    npm_pattern = re.compile(r'^\+(?!\+\+)\s*"([^"]+)"\s*:\s*"([^"]+)"', re.MULTILINE)
    pypi_pattern = re.compile(r'^\+(?!\+\+)([a-zA-Z0-9_\-]+)==([0-9\.]+)', re.MULTILINE)
    nuget_pattern = re.compile(r'^\+(?!\+\+).*<PackageReference Include="([^"]+)" Version="([^"]+)"', re.MULTILINE)

    print(f"🔍 Checking newly staged dependencies for {MIN_AGE_DAYS}-day quarantine rule...")

    # Check NPM (package.json)
    if 'package.json' in diff:
        log_info("Found package.json modifications...")
        for match in npm_pattern.findall(diff):
            pkg, raw_version = match
            version = clean_version(raw_version)
            date_str = get_publish_date_npm(pkg, version)
            check_quarantine('npm', pkg, version, date_str)

    # Check PyPI (requirements.txt)
    if 'requirements.txt' in diff:
        log_info("Found requirements.txt modifications...")
        for match in pypi_pattern.findall(diff):
            pkg, version = match
            date_str = get_publish_date_pypi(pkg, version)
            check_quarantine('PyPI', pkg, version, date_str)

    # Check NuGet (.csproj)
    if '.csproj' in diff:
        log_info("Found .csproj modifications...")
        for match in nuget_pattern.findall(diff):
            pkg, version = match
            date_str = get_publish_date_nuget(pkg, version)
            check_quarantine('NuGet', pkg, version, date_str)

    if EXIT_CODE != 0:
        print("\n🚫 Commit blocked. Please remove recent packages or wait until they pass quarantine.")
        sys.exit(EXIT_CODE)

    print("✅ All new dependencies pass the quarantine check.")
    sys.exit(0)

if __name__ == "__main__":
    main()
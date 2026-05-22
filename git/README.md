# Helpful git scripts

## Package Quarantine git hook

1. Create the Git Hook

Navigate to the root directory of your git repository and create a file named pre-commit inside the .git/hooks/ directory:

```bash
touch .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

The following [Python script](./package-quarantine-git-hook.py), currently works for Python, C# and JS projects. It analyses the staged git diffs for `package.json`, `requirements.txt`, and `.csproj` files, extracts newly added packages, and queries their respective registry APIs to check their publish dates.

Important Nuances to Keep in Mind

- Version Ranges (^ or ~): If an npm package is added as ^1.2.3, the script strips the ^ and checks the exact 1.2.3 release date. It does not resolve the highest available version the way npm does. It relies on checking the baseline version you explicitly added to the manifest.

- Lockfiles: This script checks package.json, requirements.txt, and .csproj. Parsing diffs from lockfiles (package-lock.json, poetry.lock) is incredibly complex due to transitive dependencies. This hook secures the direct dependencies you declare.

- API Rate Limits: The script makes unauthenticated GET requests to public registries. If you commit massive lists of dependencies simultaneously, you could temporarily hit rate limits. For daily use, it will work perfectly.
#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] <JWT_TOKEN>

Decode and display JWT (JSON Web Token) contents.

OPTIONS:
    -h, --help      Show this help message
    -r, --raw       Output raw JSON without formatting
    -p, --pretty    Pretty print JSON (default)

EXAMPLES:
    $(basename "$0") eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
    echo "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." | $(basename "$0")
    $(basename "$0") -r eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
EOF
    exit 0
}

# Function to decode base64url
base64url_decode() {
    local input="$1"
    # Add padding if needed
    local padded="$input"
    case $((${#input} % 4)) in
        2) padded="${input}==" ;;
        3) padded="${input}=" ;;
    esac
    # Replace base64url chars with base64 chars and decode
    echo "$padded" | tr '_-' '/+' | base64 -d 2>/dev/null
}

# Function to pretty print JSON
pretty_json() {
    if command -v jq &> /dev/null; then
        jq '.' 2>/dev/null || cat
    elif command -v python3 &> /dev/null; then
        python3 -m json.tool 2>/dev/null || cat
    else
        cat
    fi
}

# Parse arguments
PRETTY=true
TOKEN=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        -r|--raw)
            PRETTY=false
            shift
            ;;
        -p|--pretty)
            PRETTY=true
            shift
            ;;
        *)
            TOKEN="$1"
            shift
            ;;
    esac
done

# Read from stdin if no token provided
if [[ -z "$TOKEN" ]]; then
    if [[ -t 0 ]]; then
        echo -e "${RED}Error: No JWT token provided${NC}" >&2
        echo "Use -h or --help for usage information" >&2
        exit 1
    else
        read -r TOKEN
    fi
fi

# Remove any whitespace
TOKEN=$(echo "$TOKEN" | tr -d '[:space:]')

# Validate JWT format (should have 3 parts separated by dots)
IFS='.' read -ra PARTS <<< "$TOKEN"
if [[ ${#PARTS[@]} -ne 3 ]]; then
    echo -e "${RED}Error: Invalid JWT format. Expected 3 parts separated by dots${NC}" >&2
    exit 1
fi

# Extract parts
HEADER="${PARTS[0]}"
PAYLOAD="${PARTS[1]}"
SIGNATURE="${PARTS[2]}"

# Decode header
echo -e "${BLUE}=== JWT Header ===${NC}"
DECODED_HEADER=$(base64url_decode "$HEADER")
if [[ -z "$DECODED_HEADER" ]]; then
    echo -e "${RED}Error: Failed to decode header${NC}" >&2
    exit 1
fi

if [[ "$PRETTY" == true ]]; then
    echo "$DECODED_HEADER" | pretty_json
else
    echo "$DECODED_HEADER"
fi

echo ""

# Decode payload
echo -e "${BLUE}=== JWT Payload ===${NC}"
DECODED_PAYLOAD=$(base64url_decode "$PAYLOAD")
if [[ -z "$DECODED_PAYLOAD" ]]; then
    echo -e "${RED}Error: Failed to decode payload${NC}" >&2
    exit 1
fi

if [[ "$PRETTY" == true ]]; then
    echo "$DECODED_PAYLOAD" | pretty_json
else
    echo "$DECODED_PAYLOAD"
fi

echo ""

# Display signature (can't decode without secret)
echo -e "${BLUE}=== JWT Signature ===${NC}"
echo -e "${YELLOW}$SIGNATURE${NC}"
echo -e "${YELLOW}(Signature verification requires the secret key)${NC}"

# Display expiration warning if present
if command -v jq &> /dev/null; then
    EXP=$(echo "$DECODED_PAYLOAD" | jq -r '.exp // empty' 2>/dev/null)
    if [[ -n "$EXP" ]]; then
        CURRENT_TIME=$(date +%s)
        if [[ "$EXP" -lt "$CURRENT_TIME" ]]; then
            echo ""
            echo -e "${RED}⚠ WARNING: Token has expired${NC}"
        else
            REMAINING=$((EXP - CURRENT_TIME))
            echo ""
            echo -e "${GREEN}✓ Token is valid for $((REMAINING / 3600)) hours $((REMAINING % 3600 / 60)) minutes${NC}"
        fi
    fi
fi

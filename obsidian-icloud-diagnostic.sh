#!/bin/bash

# Obsidian + iCloud Drive Diagnostic Script
# This script checks your system for common iCloud + Obsidian sync issues

echo "=========================================="
echo "Obsidian + iCloud Diagnostic Tool"
echo "=========================================="
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Track issues found
ISSUES_FOUND=0

# Function to print status
print_status() {
    local status=$1
    local message=$2

    if [ "$status" == "OK" ]; then
        echo -e "${GREEN}✓${NC} $message"
    elif [ "$status" == "WARNING" ]; then
        echo -e "${YELLOW}⚠${NC} $message"
        ((ISSUES_FOUND++))
    elif [ "$status" == "ERROR" ]; then
        echo -e "${RED}✗${NC} $message"
        ((ISSUES_FOUND++))
    else
        echo -e "${BLUE}ℹ${NC} $message"
    fi
}

# Check 1: Operating System
echo "=== System Information ==="
OS_TYPE=$(uname -s)
print_status "INFO" "Operating System: $OS_TYPE"

if [ "$OS_TYPE" != "Darwin" ]; then
    print_status "WARNING" "This script is designed for macOS. iCloud Drive is an Apple service."
    echo ""
    echo "If you're on Linux/Windows, consider using:"
    echo "  - Obsidian Sync (official)"
    echo "  - Syncthing"
    echo "  - Git-based sync"
    echo ""
fi

echo ""

# Check 2: iCloud Drive Path
echo "=== iCloud Drive Status ==="

ICLOUD_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
ICLOUD_DRIVE_PATH="$HOME/iCloud Drive"

if [ -d "$ICLOUD_PATH" ]; then
    print_status "OK" "iCloud Drive directory found at: $ICLOUD_PATH"
elif [ -L "$ICLOUD_DRIVE_PATH" ] || [ -d "$ICLOUD_DRIVE_PATH" ]; then
    print_status "OK" "iCloud Drive accessible at: $ICLOUD_DRIVE_PATH"
    ICLOUD_PATH="$ICLOUD_DRIVE_PATH"
else
    print_status "ERROR" "iCloud Drive directory not found!"
    echo "  Expected location: $ICLOUD_PATH"
    echo "  Alternative: $ICLOUD_DRIVE_PATH"
    echo ""
    echo "  Solutions:"
    echo "  1. Enable iCloud Drive: System Settings → Apple ID → iCloud → iCloud Drive"
    echo "  2. Make sure you're logged into iCloud"
    echo "  3. Check if iCloud Drive is syncing"
fi

echo ""

# Check 3: Look for Obsidian vaults in iCloud
echo "=== Obsidian Vault Detection ==="

if [ -d "$ICLOUD_PATH" ]; then
    # Look for .obsidian folders (indicates vault)
    VAULTS_FOUND=$(find "$ICLOUD_PATH" -name ".obsidian" -type d 2>/dev/null | head -10)

    if [ -n "$VAULTS_FOUND" ]; then
        print_status "OK" "Found Obsidian vault(s) in iCloud Drive:"
        echo "$VAULTS_FOUND" | while read -r vault; do
            VAULT_DIR=$(dirname "$vault")
            VAULT_NAME=$(basename "$VAULT_DIR")
            echo "    → $VAULT_NAME at $VAULT_DIR"

            # Check if vault has files
            FILE_COUNT=$(find "$VAULT_DIR" -type f -name "*.md" 2>/dev/null | wc -l)
            echo "      Files: $FILE_COUNT markdown files"
        done
    else
        print_status "WARNING" "No Obsidian vaults found in iCloud Drive"
        echo "  Searched in: $ICLOUD_PATH"
        echo ""
        echo "  To fix:"
        echo "  1. Move your vault to iCloud Drive"
        echo "  2. In Obsidian: Open another vault → Open folder as vault"
        echo "  3. Navigate to your vault in iCloud Drive"
    fi
else
    print_status "ERROR" "Cannot search for vaults - iCloud Drive not accessible"
fi

echo ""

# Check 4: Obsidian Installation
echo "=== Obsidian Installation ==="

OBSIDIAN_APP="/Applications/Obsidian.app"
if [ -d "$OBSIDIAN_APP" ]; then
    print_status "OK" "Obsidian is installed"

    # Check version if possible
    OBSIDIAN_VERSION=$(defaults read "$OBSIDIAN_APP/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null)
    if [ -n "$OBSIDIAN_VERSION" ]; then
        echo "    Version: $OBSIDIAN_VERSION"
    fi
else
    print_status "WARNING" "Obsidian not found at $OBSIDIAN_APP"
    echo "  Download from: https://obsidian.md"
fi

echo ""

# Check 5: Disk Space
echo "=== Storage Status ==="

if [ "$OS_TYPE" == "Darwin" ]; then
    AVAILABLE_SPACE=$(df -h "$HOME" | awk 'NR==2 {print $4}')
    USED_PERCENT=$(df -h "$HOME" | awk 'NR==2 {print $5}')

    print_status "INFO" "Available disk space: $AVAILABLE_SPACE (Used: $USED_PERCENT)"

    # Check if disk is nearly full
    USED_NUM=$(echo $USED_PERCENT | sed 's/%//')
    if [ "$USED_NUM" -gt 90 ]; then
        print_status "WARNING" "Disk is nearly full - this may affect iCloud sync"
    fi
fi

echo ""

# Check 6: File System Issues
echo "=== File System Check ==="

if [ -d "$ICLOUD_PATH" ]; then
    # Check if we can write to iCloud Drive
    TEST_FILE="$ICLOUD_PATH/.obsidian_diagnostic_test_$(date +%s)"
    if touch "$TEST_FILE" 2>/dev/null; then
        print_status "OK" "iCloud Drive is writable"
        rm "$TEST_FILE" 2>/dev/null
    else
        print_status "ERROR" "Cannot write to iCloud Drive - permission issue"
        echo "  Try: Check iCloud Drive permissions in System Settings"
    fi

    # Look for iCloud download indicators (.icloud files)
    ICLOUD_PLACEHOLDERS=$(find "$ICLOUD_PATH" -name "*.icloud" 2>/dev/null | wc -l)
    if [ "$ICLOUD_PLACEHOLDERS" -gt 0 ]; then
        print_status "WARNING" "Found $ICLOUD_PLACEHOLDERS undownloaded files (.icloud placeholders)"
        echo "  Some files are in iCloud but not downloaded locally"
        echo "  Right-click folders in Finder → Download Now"
    fi
fi

echo ""

# Check 7: Network Connectivity
echo "=== Network Connectivity ==="

if ping -c 1 apple.com &> /dev/null; then
    print_status "OK" "Network connection active"
else
    print_status "WARNING" "Cannot reach apple.com - check internet connection"
fi

echo ""

# Check 8: Common Issues
echo "=== Common Issues Check ==="

# Check for multiple Apple IDs (check keychain)
if [ "$OS_TYPE" == "Darwin" ]; then
    APPLE_ID=$(defaults read MobileMeAccounts Accounts 2>/dev/null | grep AccountID | head -1 | awk -F'"' '{print $2}')
    if [ -n "$APPLE_ID" ]; then
        print_status "INFO" "Logged in with Apple ID: $APPLE_ID"
        echo "  Make sure ALL devices use this same Apple ID"
    fi
fi

echo ""

# Summary
echo "=========================================="
echo "=== Diagnostic Summary ==="
echo "=========================================="

if [ $ISSUES_FOUND -eq 0 ]; then
    echo -e "${GREEN}✓ No issues detected!${NC}"
    echo ""
    echo "If you're still having sync problems:"
    echo "  1. Restart your Mac"
    echo "  2. Toggle iCloud Drive off/on in System Settings"
    echo "  3. Wait 5-10 minutes for sync to complete"
    echo "  4. Check System Status: https://www.apple.com/support/systemstatus/"
else
    echo -e "${YELLOW}⚠ Found $ISSUES_FOUND issue(s)${NC}"
    echo ""
    echo "Review the warnings and errors above."
    echo "See ICLOUD_OBSIDIAN_TROUBLESHOOTING.md for detailed solutions."
fi

echo ""
echo "=========================================="
echo "For detailed troubleshooting, see:"
echo "  ICLOUD_OBSIDIAN_TROUBLESHOOTING.md"
echo "=========================================="

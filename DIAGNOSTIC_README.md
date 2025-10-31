# Obsidian iCloud Diagnostic Script

An automated diagnostic tool to check your iCloud + Obsidian setup and identify common sync issues.

## What It Checks

The script automatically diagnoses:

- ✓ Operating system compatibility
- ✓ iCloud Drive status and accessibility
- ✓ Obsidian vault location and presence
- ✓ Obsidian installation
- ✓ Available disk space
- ✓ File system permissions
- ✓ Undownloaded files (.icloud placeholders)
- ✓ Network connectivity
- ✓ Apple ID configuration

## Usage

### On macOS:

```bash
chmod +x obsidian-icloud-diagnostic.sh
./obsidian-icloud-diagnostic.sh
```

### What You'll See:

The script provides color-coded output:
- **✓ Green**: Everything is working correctly
- **⚠ Yellow**: Warning - potential issue found
- **✗ Red**: Error - needs attention
- **ℹ Blue**: Information only

## Example Output

```
==========================================
Obsidian + iCloud Diagnostic Tool
==========================================

=== System Information ===
ℹ Operating System: Darwin

=== iCloud Drive Status ===
✓ iCloud Drive directory found at: /Users/you/Library/Mobile Documents/com~apple~CloudDocs

=== Obsidian Vault Detection ===
✓ Found Obsidian vault(s) in iCloud Drive:
    → MyVault at /Users/you/iCloud Drive/Obsidian/MyVault
      Files: 245 markdown files

...
```

## Common Issues Detected

### 1. iCloud Drive Not Found
**Cause:** iCloud Drive is not enabled or you're not logged into iCloud

**Solution:**
- Open System Settings → Apple ID → iCloud
- Enable iCloud Drive
- Wait a few minutes for it to initialize

### 2. No Vaults Found
**Cause:** Your Obsidian vault is not in iCloud Drive

**Solution:**
- Move your vault folder to ~/iCloud Drive/
- In Obsidian: Open another vault → Open folder as vault
- Select your vault from iCloud Drive

### 3. Undownloaded Files (.icloud placeholders)
**Cause:** Files are in iCloud but not downloaded locally

**Solution:**
- Right-click your vault folder in Finder
- Select "Download Now"
- Wait for sync to complete

### 4. Disk Nearly Full
**Cause:** Less than 10% disk space remaining

**Solution:**
- Free up disk space
- Consider upgrading iCloud storage plan
- Check iCloud storage settings

## Requirements

- macOS (iCloud Drive is Apple-exclusive)
- Bash shell
- iCloud account

## Related Documentation

- **OBSIDIAN_SYNC_GUIDE.md** - Overview of sync options
- **ICLOUD_OBSIDIAN_TROUBLESHOOTING.md** - Detailed manual troubleshooting steps

## Troubleshooting the Script

If the script doesn't run:

```bash
# Make sure it's executable
chmod +x obsidian-icloud-diagnostic.sh

# Run with bash explicitly
bash obsidian-icloud-diagnostic.sh

# Check for errors
cat obsidian-icloud-diagnostic.sh | head -1
# Should show: #!/bin/bash
```

## When to Use This Script

Run this diagnostic script when:
- Your devices can't see your Obsidian vault
- Sync is not working between devices
- Files are missing on some devices
- You're setting up iCloud sync for the first time
- You suspect iCloud Drive issues

## Limitations

- macOS only (iCloud Drive is not available on other platforms)
- Requires iCloud Drive to be at least partially set up
- Cannot fix issues automatically (provides guidance only)

## Next Steps

After running the diagnostic:

1. **0 issues found:** Your setup looks good! If still having problems:
   - Restart your devices
   - Wait 5-10 minutes for sync
   - Check [Apple System Status](https://www.apple.com/support/systemstatus/)

2. **Issues found:** Follow the solutions provided in the output
   - See ICLOUD_OBSIDIAN_TROUBLESHOOTING.md for detailed steps

3. **Still stuck:** Consider:
   - Obsidian Sync ($10/month) - hassle-free official solution
   - Alternative sync methods (Syncthing, Git, Dropbox)

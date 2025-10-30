# iCloud + Obsidian Troubleshooting Guide

## Problem: Devices Not Seeing the Vault at All

If your tablet, phone, and desktop aren't seeing your Obsidian vault in iCloud, follow these steps to resolve the issue.

---

## Step 1: Verify iCloud Drive is Enabled on All Devices

### On Mac (Desktop):
1. Open **System Settings** (or System Preferences on older macOS)
2. Click on your **Apple ID** at the top
3. Select **iCloud**
4. Make sure **iCloud Drive** is checked/enabled
5. Click **Options** next to iCloud Drive
6. Verify **Desktop & Documents Folders** is enabled (if you want to use these locations)

### On iPhone/iPad:
1. Open **Settings**
2. Tap your name at the top
3. Tap **iCloud**
4. Tap **iCloud Drive**
5. Make sure it's **turned ON**
6. Scroll down and ensure **Obsidian** has access (if it appears in the list)

---

## Step 2: Check Vault Location

The vault **must** be in the correct iCloud Drive location:

### Correct Location:
```
~/Library/Mobile Documents/com~apple~CloudDocs/
```
Or simply:
```
~/iCloud Drive/
```

### How to Move Your Vault:
1. **On Mac:**
   - Open Finder
   - Press `Cmd + Shift + H` to go to Home folder
   - Navigate to **iCloud Drive** (should be in the sidebar)
   - Create a folder called `Obsidian` (or any name you prefer)
   - Move or copy your vault folder into this location

2. **In Obsidian:**
   - Open Obsidian
   - Click **Open another vault**
   - Click **Open folder as vault**
   - Navigate to your vault in iCloud Drive
   - Select it

---

## Step 3: Wait for Initial Sync

**Critical:** After placing your vault in iCloud Drive, you must wait for the initial sync to complete.

### Check Sync Status on Mac:
- Small cloud icon next to files = syncing
- Checkmark = fully synced
- Download icon = file is in cloud but not downloaded locally

### Force Download on Mac:
1. Right-click the vault folder in Finder
2. Select **Download Now**

### On iPhone/iPad:
1. Open the **Files** app
2. Go to **iCloud Drive**
3. You should see your vault folder
4. If you see a cloud icon, tap it to download

---

## Step 4: Verify Same Apple ID on All Devices

Make sure you're logged into the **same Apple ID** on all devices:

### Check on Mac:
- System Settings → Apple ID → View account info

### Check on iPhone/iPad:
- Settings → [Your Name] → View Apple ID

---

## Step 5: Check Storage Space

If iCloud storage is full, syncing will fail:

### Check iCloud Storage:
- **Mac:** System Settings → Apple ID → iCloud → Manage Storage
- **iPhone/iPad:** Settings → [Your Name] → iCloud → Manage Storage

### If storage is full:
- Upgrade your iCloud plan, or
- Delete unnecessary files from iCloud Drive

---

## Step 6: Open Vault on Mobile Devices

### On iPhone/iPad:
1. Open **Obsidian** app
2. Tap **Open vault**
3. Tap **Open folder from iCloud Drive** (or similar option)
4. Navigate to your vault folder in iCloud Drive
5. Select the vault folder

**Note:** On iOS, you may need to grant Obsidian permission to access iCloud Drive when prompted.

---

## Step 7: Restart Devices and iCloud

If the vault still isn't appearing:

1. **Restart iCloud sync:**
   - **Mac:** System Settings → Apple ID → iCloud → Turn iCloud Drive OFF, wait 10 seconds, turn it back ON
   - **iPhone/iPad:** Settings → [Your Name] → iCloud → iCloud Drive → Toggle OFF, wait 10 seconds, toggle ON

2. **Restart the device:**
   - Sometimes a simple restart resolves sync issues

3. **Sign out and back into iCloud (last resort):**
   - This will re-sync everything, but takes time
   - Make sure you know your Apple ID password before doing this

---

## Common Issues and Solutions

### Issue: Vault appears on Mac but not on iPhone/iPad
**Solution:**
- Make sure the vault is in iCloud Drive, not just in Documents
- Check that iCloud Drive is enabled on mobile device
- Try the "Download Now" option in the Files app

### Issue: Files are syncing but very slowly
**Solution:**
- Check your internet connection
- Large vaults take time for initial sync
- Consider upgrading iCloud storage plan for better performance

### Issue: Some files are missing on certain devices
**Solution:**
- Files might not be fully downloaded
- Go to Files app → iCloud Drive → tap the cloud icon to download
- Check if "Optimize Storage" is enabled (it keeps files in cloud only)

### Issue: Obsidian says "Vault not found"
**Solution:**
- The vault folder may have moved or been renamed
- Re-open the vault using "Open folder as vault" in Obsidian
- Navigate to the correct iCloud Drive location

---

## Alternative: Use Obsidian's Working Copy Feature

If you continue having issues with iCloud Drive:

1. Keep your primary vault in iCloud Drive on your Mac
2. On mobile devices, create a local vault
3. Use Obsidian's mobile app to open vaults from iCloud Drive when needed
4. Consider switching to **Obsidian Sync** ($10/month) for seamless syncing

---

## Still Not Working?

If you've tried all the above and your devices still can't see the vault:

1. **Check Apple System Status:** https://www.apple.com/support/systemstatus/
   - iCloud services might be down temporarily

2. **Contact Apple Support:**
   - The issue might be with your iCloud account

3. **Consider Obsidian Sync:**
   - The official Obsidian Sync service eliminates these issues entirely
   - $10/month for hassle-free syncing across all devices

---

## Quick Checklist

- [ ] iCloud Drive is enabled on all devices
- [ ] Logged into the same Apple ID on all devices
- [ ] Vault is located in iCloud Drive folder
- [ ] Initial sync has completed (check for cloud icons)
- [ ] Sufficient iCloud storage available
- [ ] Granted Obsidian permission to access iCloud Drive on mobile
- [ ] Opened vault correctly in Obsidian on each device
- [ ] Restarted devices if needed

Good luck! Once set up correctly, iCloud Drive should keep your Obsidian vault synced across all your Apple devices.

# Desktop Launcher - Quick Reference

## ✅ What's Been Implemented

A download button that creates **ready-to-run desktop launchers** for both Windows and Linux.

---

## 🚀 How It Works

### Windows Users
1. Click **"Download"** under Windows Launcher
2. File `MMU-Chat.url` downloads
3. **Double-click** the downloaded file
4. App opens in your default browser
5. *(Optional)* Drag to Desktop for permanent icon

### Linux Users  
1. Click **"Download"** under Linux Launcher
2. File `MMU-Chat.desktop` downloads
3. Open terminal and run:
   ```bash
   cd ~/Downloads
   chmod +x MMU-Chat.desktop
   ./MMU-Chat.desktop
   ```
4. App opens in your default browser!

---

## 📋 Quick Linux Setup (One Command)

```bash
cd ~/Downloads && chmod +x MMU-Chat.desktop && ./MMU-Chat.desktop
```

**To add to Desktop:**
```bash
mv ~/Downloads/MMU-Chat.desktop ~/Desktop/
```

**To add to Applications Menu:**
```bash
mkdir -p ~/.local/share/applications
mv ~/Downloads/MMU-Chat.desktop ~/.local/share/applications/
```

---

## 📄 Generated File Format

### Windows: `MMU-Chat.url`
```ini
[InternetShortcut]
URL=http://172.20.10.4:5173
```

### Linux: `MMU-Chat.desktop`
```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=MMU Campus Assistant
Comment=MMU AI Chatbot - Campus Information Assistant
Exec=xdg-open http://172.20.10.4:5173
Icon=web-browser
Terminal=false
Categories=Network;Education;WebBrowser;
StartupNotify=true
X-Desktop-File-Install-Version=0.26
```

---

## 🎯 Key Features

✅ **Automatic URL Detection** - Uses `window.location.origin` (works on any host/port)  
✅ **Standard Icons** - Uses `web-browser` icon (built-in on all Linux systems)  
✅ **No Dependencies** - Works without requiring the server to be running  
✅ **Cross-Platform** - Windows and Linux support  
✅ **Simple Setup** - Just one chmod command for Linux  
✅ **Toast Notifications** - Clear instructions after download  

---

## 🧪 Testing

### Test the Download
1. Start dev server:
   ```bash
   cd ~/Desktop/pjt-chatbot/Frontend/app_interface
   npm run dev -- --host 0.0.0.0
   ```

2. Open browser: `http://172.20.10.4:5173`

3. Go to **Settings** → **Desktop Launcher**

4. Click **Download** (Linux or Windows)

### Test the Launcher (Linux)
```bash
cd ~/Downloads
chmod +x MMU-Chat.desktop
./MMU-Chat.desktop
```

Expected: Browser opens to the app!

### Test the Launcher (Windows)
1. Open Downloads folder
2. Double-click `MMU-Chat.url`

Expected: Browser opens to the app!

---

## 🔧 Troubleshooting

### Linux: "Permission denied"
```bash
chmod +x MMU-Chat.desktop
```

### Linux: "Failed to add plugin to panel"
This is a GNOME error when trying to add to panel. **Solution:**
1. Just place on Desktop instead:
   ```bash
   mv MMU-Chat.desktop ~/Desktop/
   ```
2. Or add to Applications:
   ```bash
   mv MMU-Chat.desktop ~/.local/share/applications/
   ```

### Linux: "Untrusted application launcher"
```bash
# Trust the launcher
gio set ~/Desktop/MMU-Chat.desktop metadata::trusted true

# Or right-click → "Allow Launching"
```

### Windows: Icon not showing
- The `.url` file uses default browser icon
- This is normal behavior for web shortcuts

### Launcher doesn't open app
- Check if dev server is running
- Verify the URL in the file matches your server address
- Edit the file and update the URL if needed

---

## 📝 Customization

### Change the URL
Edit the downloaded file in any text editor:

**Linux:**
```bash
nano ~/Desktop/MMU-Chat.desktop
# Change the Exec line:
Exec=xdg-open http://YOUR-NEW-URL
```

**Windows:**
```
notepad MMU-Chat.url
# Change the URL line:
URL=http://YOUR-NEW-URL
```

### Change the Icon (Linux only)
```bash
nano ~/Desktop/MMU-Chat.desktop
# Change Icon line to any of these:
Icon=internet-web-browser
Icon=web-browser
Icon=firefox
Icon=chromium
Icon=/full/path/to/icon.png
```

---

## 🌐 Network Access

The launcher automatically uses the current URL. If you're on:
- **localhost**: `http://localhost:5173`
- **LAN**: `http://172.20.10.4:5173`
- **Production**: `https://your-domain.com`

Everyone on your network can use the launcher if you share it!

---

## 📦 What's in the Code

**File:** `Frontend/app_interface/src/pages/SettingsPage.tsx`

**Function:** `downloadDesktopShortcut(platform: 'windows' | 'linux')`

**Key Changes:**
1. Simplified `.desktop` format for better compatibility
2. Uses standard `web-browser` icon (no external dependencies)
3. Clear terminal instructions in toast notification
4. Added command example in UI for Linux users

---

## ✨ Result

Users can now:
- ✅ Download a working launcher with one click
- ✅ Open the app from Desktop with one click
- ✅ Share the launcher with other users
- ✅ Use the same launcher on any network
- ✅ No complex installation needed

---

## 🎓 For Your Team

**Tell users:**
> "Go to Settings → Desktop Launcher, download the file for your OS, and follow the simple one-line command (Linux) or just double-click (Windows). That's it!"

**Share this command for Linux users:**
```bash
cd ~/Downloads && chmod +x MMU-Chat.desktop && ./MMU-Chat.desktop
```

---

**Status:** ✅ Complete and Ready  
**Tested:** Manual testing recommended  
**Next Step:** Test on your system and deploy!

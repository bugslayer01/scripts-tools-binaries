# 📦 AppImage Desktop Installer

A simple bash script to easily install `.AppImage` applications on Linux with desktop integration.

---

## 🛠️ Features

- 🗂️ **Browse and select AppImage** from a custom or default folder  
- 📁 **Moves AppImage** to a central folder: `~/allAppImages`  
- 🖼️ **Extracts icon** from AppImage automatically  
- 🧷 **Creates a `.desktop` file** for app launcher integration  
- 🔄 **Refreshes the app menu** so you can find it immediately

---

## 📥 Installation

1. **Make it executable**

```bash
chmod +x appimage_inst.sh
```

2. **(Optional) Move to PATH for global use**

```bash
sudo mv appimage_inst.sh /usr/local/bin/appimage_inst
```

---

## 🚀 Usage

Run the script like this:

```bash
./appimage_inst.sh
```

or if you moved it to your `$PATH`:

```bash
appimage_inst
```

---

## 📂 Workflow

1. You are prompted to **enter a directory** where your `.AppImage` files are stored.  
   - Leave blank to use the default: `~/allAppImages`

2. The script shows you a **menu of `.AppImage` files** in that directory.

3. You **select one**, and the script will:
   - Move it (if needed) to `~/allAppImages`
   - Extract its icon (if available)
   - Create a `.desktop` launcher in `~/.local/share/applications`
   - Refresh the desktop menu

4. ✅ Done! Now you can **launch your AppImage like a normal app** from the system menu.

---

## 📝 Notes

- The script uses `--appimage-extract` to get icons. This may not work for all AppImages.
- If no icon is found, a fallback icon is used.
- This script is user-local (no root needed).
- Tested on: Ubuntu, Fedora, Arch, Manjaro.

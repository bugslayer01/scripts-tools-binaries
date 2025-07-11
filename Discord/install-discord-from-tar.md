# 📦 Discord Installer Script an overview by chat gpt 

A Bash script to install the latest version of **Discord** from a `.tar.gz` archive on Linux systems.  
This is especially useful for Arch Linux or other distros where the official Discord package may be outdated or not preferred.

---

## ⚙️ Features

- ✅ Accepts manual input or auto-detects `discord-*.tar.gz` files from `~/Downloads`
- ✅ Supports multiple `.tar.gz` versions — prompts user to choose
- ✅ Extracts and installs to `/opt/discord`
- ✅ Creates a `.desktop` shortcut for easy launch from application menu
- ✅ Creates a symlink `/usr/bin/discord` for CLI access
- ✅ Minimal dependencies — only `bash`, `tar`, and `sudo` required

---

## 🧑‍💻 How to Use

1. **Download the latest Discord `.tar.gz`** from [https://discord.com/download](https://discord.com/download)

2. **Clone or save the script**:

   ```bash
   nano install-discord-from-tar.sh
   # Paste the full script contents here, then save (Ctrl+O, Enter, Ctrl+X)
   chmod +x install-discord-from-tar.sh
   ```

3. **Run the script**:

   ```bash
   ./install-discord-from-tar.sh
   ```

4. **Follow prompts**:
   - If multiple `.tar.gz` versions are found in `~/Downloads`, you'll be asked to choose  (not tested)

---

## 📁 What It Does Internally

- Extracts the `.tar.gz` to a temp directory
- Removes any existing `/opt/discord`
- Moves the new `Discord` folder to `/opt/discord`
- Creates a shortcut at: `/usr/share/applications/discord.desktop`
- Adds a symlink to: `/usr/bin/discord`

---

## ⚠️ Notes & Edge Cases

- If `discord.png` (icon) is missing from the `.tar.gz`, the launcher may appear without an icon
- If Discord is running while installing, you may experience issues (recommended to close it first)
- Previous Discord installation in `/opt/discord` will be **overwritten**

---

## 🧼 Uninstall

```bash
sudo rm -rf /opt/discord
sudo rm /usr/share/applications/discord.desktop
sudo rm /usr/bin/discord
```

---

## ✅ Will this script work on any Linux machine?

Short answer: **It works on most Linux machines**, but not every machine out-of-the-box.

---

### ✅ Works On

This script should work without modification on:

- **Arch Linux**
- **Debian / Ubuntu**
- **Manjaro / EndeavourOS / Garuda**
- **Fedora**
- **Any distro with GUI + bash + sudo + tar**
---

## 📜 License

MIT License — use freely, modify as needed.

#!/bin/bash

DEFAULT_DIR="$HOME/allAppImages"
APP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"

read -rp "Enter directory where AppImages are located (leave blank for default: $DEFAULT_DIR): " USER_DIR
APPIMAGE_DIR="${USER_DIR:-$DEFAULT_DIR}"

if [ ! -d "$APPIMAGE_DIR" ]; then
    echo " Directory does not exist: $APPIMAGE_DIR"
    exit 1
fi

echo " Available AppImages in $APPIMAGE_DIR:"
select FILE in "$APPIMAGE_DIR"/*.AppImage; do
    if [ -n "$FILE" ]; then
        echo "You selected: $FILE"
        break
    else
        echo " Invalid selection. Try again."
    fi
done

APPIMAGE_PATH="$(realpath "$FILE")"
BASENAME="$(basename "$APPIMAGE_PATH")"
NAME="${BASENAME%.AppImage}"

if [[ "$APPIMAGE_PATH" != "$DEFAULT_DIR/"* ]]; then
    echo "📁 Moving AppImage to $DEFAULT_DIR..."
    mkdir -p "$DEFAULT_DIR"
    mv "$APPIMAGE_PATH" "$DEFAULT_DIR/$BASENAME"
    APPIMAGE_PATH="$DEFAULT_DIR/$BASENAME"
fi

mkdir -p "$ICON_DIR"
chmod +x "$APPIMAGE_PATH"
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR" || exit
"$APPIMAGE_PATH" --appimage-extract > /dev/null 2>&1

ICON_FILE=$(find squashfs-root -type f -name "*.png" | head -n 1)
ICON_NAME="$NAME.png"

if [ -f "$ICON_FILE" ]; then
    cp "$ICON_FILE" "$ICON_DIR/$ICON_NAME"
    ICON="$ICON_NAME"
else
    ICON="application-default-icon"
fi

mkdir -p "$APP_DIR"
DESKTOP_FILE="$APP_DIR/$NAME.desktop"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=$NAME
Exec=$APPIMAGE_PATH
Icon=$ICON
Type=Application
Categories=Utility;
Terminal=false
EOF

chmod +x "$DESKTOP_FILE"

cd ~ || exit
rm -rf "$TEMP_DIR"

echo " Desktop file created at: $DESKTOP_FILE"
echo " AppImage is located at: $APPIMAGE_PATH"
update-desktop-database "$APP_DIR" > /dev/null 2>&1

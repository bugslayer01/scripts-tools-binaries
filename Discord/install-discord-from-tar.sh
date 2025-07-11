
set -e
set -o pipefail

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

function info() {
    echo -e "${GREEN}[INFO]${RESET} $1"
}

function warn() {
    echo -e "${YELLOW}[WARN]${RESET} $1"
}

function error() {
    echo -e "${RED}[ERROR]${RESET} $1" >&2
}

function find_discord_tarballs() {
    find "$1" -maxdepth 1 -type f -name "discord*.tar.gz"
}

function choose_tarball() {
    local files=("$@")
    echo "Multiple Discord versions found:"
    select file in "${files[@]}"; do
        if [[ -n "$file" ]]; then
            echo "$file"
            return
        else
            echo "Invalid selection."
        fi
    done
}

function get_tarball_path() {
    read -p "Enter path to discord tar.gz file (leave blank to search ~/Downloads): " user_input
    if [[ -n "$user_input" && -f "$user_input" ]]; then
        echo "$user_input"
    else
        mapfile -t tarballs < <(find "$HOME/Downloads" -maxdepth 1 -type f -name "discord*.tar.gz")

        if [[ ${#tarballs[@]} -eq 0 ]]; then
            error "No Discord tarballs found in ~/Downloads."
            exit 1
        elif [[ ${#tarballs[@]} -eq 1 ]]; then
            echo "${tarballs[0]}"
        else
            echo -e "${GREEN}[INFO]${RESET} Found multiple Discord versions."
            choose_tarball "${tarballs[@]}"
        fi
    fi
}


function install_discord() {
    local tar_path="$1"
    local extract_dir
    extract_dir=$(mktemp -d)

    echo -e "${GREEN}[INFO]${RESET} Extracting: $tar_path"
    if ! tar -xzf "$tar_path" -C "$extract_dir"; then
        error "Failed to extract $tar_path"
        exit 1
    fi

    if [[ ! -d "$extract_dir/Discord" ]]; then
        error "Discord directory not found after extraction."
        exit 1
    fi

    echo -e "${GREEN}[INFO]${RESET} Installing to /opt/discord (requires sudo)..."
    sudo rm -rf /opt/discord
    sudo mv "$extract_dir/Discord" /opt/discord
    sudo ln -sf /opt/discord/Discord /usr/bin/discord

    echo -e "${GREEN}[INFO]${RESET} Creating desktop entry..."
    sudo tee /usr/share/applications/discord.desktop > /dev/null <<EOF
[Desktop Entry]
Name=Discord
Comment=Discord Voice and Text Chat
Exec=/opt/discord/Discord
Icon=/opt/discord/discord.png
Terminal=false
Type=Application
Categories=Network;InstantMessaging;
EOF

    echo -e "${GREEN}[INFO]${RESET} Discord installation complete!"
}

tar_path=$(get_tarball_path)
install_discord "$tar_path"

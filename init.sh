#!/usr/bin/env bash
set -Eeuo pipefail

GREEN="\033[1;32m"
RESET="\033[0m"

# Directory of this script
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

FONT_DIR="$HOME/.local/share/fonts"
CONFIG_DIR="$HOME/.config"

print_banner() {
echo -e "${GREEN}"
cat << "EOF"
███████╗██╗  ██╗██╗██████╗ ██████╗  ██████╗ ██╗  ██╗
██╔════╝██║  ██║██║╚════██╗██╔══██╗██╔═══██╗╚██╗██╔╝
███████╗███████║██║ █████╔╝██████╔╝██║   ██║ ╚███╔╝
╚════██║██╔══██║██║ ╚═══██╗██╔══██╗██║   ██║ ██╔██╗
███████║██║  ██║██║██████╔╝██████╔╝╚██████╔╝██╔╝ ██╗
╚══════╝╚═╝  ╚═╝╚═╝╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝

                   x@sh3llvik
EOF
echo -e "${RESET}"
}

install_packages() {
echo "[+] Updating system..."
sudo apt update && sudo apt upgrade -y

echo "[+] Installing packages..."

sudo apt install -y \
i3 \
i3blocks \
terminator \
synapse \
caja \
lxappearance \
tmux \
feh \
npm \
lsd \
flameshot \
neovim \
rofi \
unzip \
wget \
curl
}

install_fonts() {

echo "[+] Installing Nerd Fonts..."

mkdir -p "$FONT_DIR"

fonts=(
JetBrainsMono
Meslo
CascadiaMono
)

for font in "${fonts[@]}"; do
    url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/${font}.zip"
    zip="/tmp/${font}.zip"

    wget -q -O "$zip" "$url"
    unzip -o "$zip" -d "$FONT_DIR"
    rm -f "$zip"
done

fc-cache -fv
}

install_icons() {
echo "[+] Installing icon theme..."
sudo unzip -o "$REPO_DIR/src/Material-Black-Lime-Numix-FLAT.zip" -d /usr/share/icons/
}

install_wallpaper() {
echo "[+] Installing wallpapers..."

mkdir -p "$HOME/.wallpaper"

if [ -d "$REPO_DIR/src/wallpaper" ]; then
    cp -r "$REPO_DIR/src/wallpaper/*" "$HOME/.wallpaper/" 2>/dev/null || true
fi

if [ -f "$REPO_DIR/src/fehbg" ]; then
    cp "$REPO_DIR/src/fehbg" "$HOME/.fehbg"
fi
}

install_vpn() {
echo "[+] Installing VPN configs..."

sudo cp -r "$REPO_DIR/src/vpn-config" /etc/
sudo chmod +x /etc/vpn-config/*.sh
sudo cp /etc/vpn-config/default.conf /etc/openvpn/
sudo ln -sf /etc/vpn-config/shvpn.sh /usr/local/bin/shvpn
}

install_shell_configs() {
echo "[+] Installing shell configs..."

cp "$REPO_DIR/src/bashrc" "$HOME/.bashrc"
cp "$REPO_DIR/src/tmux.conf" "$HOME/.tmux.conf"
}

install_app_configs() {
echo "[+] Installing application configs..."

mkdir -p "$CONFIG_DIR"

configs=(
terminator
nvim
picom
i3
rofi
)

for cfg in "${configs[@]}"; do
    cp -r "$REPO_DIR/config/$cfg" "$CONFIG_DIR/"
done

chmod +x "$CONFIG_DIR/i3/scripts/"* 2>/dev/null || true
}

main() {

print_banner
install_packages
install_fonts
install_icons
install_wallpaper
install_vpn
install_shell_configs
install_app_configs

echo
echo "[+] shi3box installation complete."
echo "[+] Logout and select the i3 session."
}

main

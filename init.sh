#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------------- Colors ----------------
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

log()  { echo -e "${CYAN}➜ $1${RESET}"; }
ok()   { echo -e "${GREEN}✔ $1${RESET}"; }
warn() { echo -e "${YELLOW}⚠ $1${RESET}"; }
err()  { echo -e "${RED}✘ $1${RESET}"; }

# ---------------- System Update ----------------
log "Updating system..."
sudo apt update -y && sudo apt upgrade -y
ok "System updated"

# ---------------- Essential Packages ----------------
log "Installing essential packages..."

sudo apt install -y \
linux-headers-$(uname -r) \
build-essential dkms \
meson ninja-build autoconf \
libxcb-shape0-dev libxcb-keysyms1-dev \
libpango1.0-dev libxcb-util0-dev \
libxcb1-dev libxcb-icccm4-dev \
libyajl-dev libev-dev \
libxcb-xkb-dev libxcb-cursor-dev \
libxkbcommon-dev libxcb-xinerama0-dev \
libxkbcommon-x11-dev \
libstartup-notification0-dev \
libxcb-randr0-dev libxcb-xrm-dev \
libxcb-render-util0-dev libxcb-xfixes0-dev \
unzip feh lxappearance rofi flameshot \
thunar tmux neovim python3-pip \
papirus-icon-theme arc-theme \
imagemagick fonts-font-awesome \
fonts-jetbrains-mono fonts-cascadia-code \
i3-wm i3lock i3status i3blocks \
picom kitty terminator synapse \
network-manager nmcli \
npm caja

ok "Packages installed"

# ---------------- Nerd Fonts ----------------
log "Installing Nerd Fonts..."

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip >/dev/null
rm JetBrainsMono.zip

fc-cache -fv >/dev/null
ok "Nerd Fonts installed"

# ---------------- Config Copy ----------------
log "Deploying configs..."

backup_copy() {
  SRC="$1"
  DEST="$2"

  if [ -e "$DEST" ]; then
    mv "$DEST" "$DEST.bak"
    warn "Backup created → $DEST.bak"
  fi

  cp -r "$SRC" "$DEST"
  ok "Copied → $DEST"
}

mkdir -p ~/.config

backup_copy "$SCRIPT_DIR/config/i3" "$HOME/.config/i3"
backup_copy "$SCRIPT_DIR/config/i3blocks" "$HOME/.config/i3blocks"
backup_copy "$SCRIPT_DIR/config/nvim" "$HOME/.config/nvim"
backup_copy "$SCRIPT_DIR/config/rofi" "$HOME/.config/rofi"
backup_copy "$SCRIPT_DIR/config/kitty" "$HOME/.config/kitty"
backup_copy "$SCRIPT_DIR/config/picom" "$HOME/.config/picom"
backup_copy "$SCRIPT_DIR/config/terminator" "$HOME/.config/terminator"

# Script permissions
if [ -d "$HOME/.config/i3/scripts" ]; then
  chmod +x ~/.config/i3/scripts/*
  ok "i3 scripts executable"
fi

# ---------------- Bashrc ----------------
backup_copy "$SCRIPT_DIR/src/bashrc" "$HOME/.bashrc"

# ---------------- Tmux ----------------
backup_copy "$SCRIPT_DIR/src/tmux.conf" "$HOME/.tmux.conf"

# ---------------- Wallpaper ----------------
mkdir -p ~/.wallpaper
cp -r "$SCRIPT_DIR/src/wallpaper/"* ~/.wallpaper/ 2>/dev/null || true
cp "$SCRIPT_DIR/src/.fehbg" ~/.fehbg 2>/dev/null || true
ok "Wallpaper deployed"

# ---------------- VPN Setup ----------------
log "Configuring VPN scripts..."

if [ -d "$SCRIPT_DIR/src/vpn-config" ]; then
  sudo cp -r "$SCRIPT_DIR/src/vpn-config" /etc/
  sudo chmod +x /etc/vpn-config/*.sh 2>/dev/null || true
  sudo ln -sf /etc/vpn-config/shvpn.sh /usr/local/bin/shvpn
  ok "VPN configured"
else
  warn "VPN config not found, skipped"
fi

# ---------------- Sublime Text ----------------
log "Installing Sublime Text..."

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg \
| gpg --dearmor \
| sudo tee /usr/share/keyrings/sublimehq.gpg >/dev/null

echo "deb [signed-by=/usr/share/keyrings/sublimehq.gpg] https://download.sublimetext.com/ apt/stable/" \
| sudo tee /etc/apt/sources.list.d/sublime-text.list >/dev/null

sudo apt update
sudo apt install -y sublime-text

ok "Sublime installed"

# ---------------- Finish ----------------
echo
ok "shi3box installation complete"
echo -e "${CYAN}Reboot and select i3 session.${RESET}"

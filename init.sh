#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

log()  { echo -e "${CYAN}➜ $1${RESET}"; }
ok()   { echo -e "${GREEN}✔ $1${RESET}"; }
warn() { echo -e "${YELLOW}⚠ $1${RESET}"; }
err()  { echo -e "${RED}✘ $1${RESET}"; }

log "Updating system..."
sudo apt update -y && sudo apt upgrade -y
ok "System updated"

log "Installing required packages..."

sudo apt install -y \
build-essential \
dkms \
linux-headers-$(uname -r) \
meson \
ninja-build \
autoconf \
unzip \
feh \
lxappearance \
rofi \
flameshot \
thunar \
tmux \
neovim \
python3-pip \
papirus-icon-theme \
arc-theme \
imagemagick \
fonts-font-awesome \
fonts-jetbrains-mono \
fonts-cascadia-code \
i3-wm \
i3lock \
i3status \
i3blocks \
picom \
kitty \
terminator \
synapse \
network-manager \
procps \
iproute2 \
npm

ok "Packages installed"

log "Installing Nerd Fonts..."

sudo mkdir -p /usr/local/share/fonts
cd /usr/local/share/fonts

sudo wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
sudo unzip -o JetBrainsMono.zip >/dev/null
sudo rm JetBrainsMono.zip

fc-cache -fv >/dev/null
ok "Fonts installed"

log "Deploying configs..."

backup_copy() {
  SRC="$1"
  DEST="$2"

  if [ -e "$DEST" ]; then
    mv "$DEST" "$DEST.bak"
    warn "Backup → $DEST.bak"
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

chmod +x ~/.config/i3/scripts/* 2>/dev/null || true
ok "Script permissions fixed"

backup_copy "$SCRIPT_DIR/src/bashrc" "$HOME/.bashrc"
backup_copy "$SCRIPT_DIR/src/tmux.conf" "$HOME/.tmux.conf"

mkdir -p ~/.wallpaper
cp -r "$SCRIPT_DIR/src/wallpaper/"* ~/.wallpaper/ 2>/dev/null || true
cp "$SCRIPT_DIR/src/.fehbg" ~/.fehbg 2>/dev/null || true

ok "shi3box installation complete"
echo -e "${CYAN}Reboot → Select i3 session${RESET}"

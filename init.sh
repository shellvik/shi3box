#!/bin/bash

set -e 
SCRIPT_DIR=$(dirname "$(realpath "$0")")

#-------------------------Colors-------------------------------------
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"
# -------------------------------------------------------------------

#--------------------- Update the System & Install Necessary pkg-----
sudo apt update && sudo apt upgrade -y
sudo apt install -y linux-headers-$(uname -r) build-essential dkms
sudo apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson
sudo apt-get install -y libxcb-render-util0-dev libxcb-shape0-dev libxcb-xfixes0-dev 
#--------------------------------------------------------------------

#-------------------Install Essential Packages-----------------------
install_pkg() {
  local packages=(
              synapse
              unzip
              i3lock 
              i3status
              i3blocks
              i3
              i3-wm
              compton
              picom
              tmux
              feh 
              lxappearance  
              rofi 
              kitty 
              terminator 
              npm 
              neovim
              caja
              thunar
              flameshot
              arc-theme
              python3-pip
              papirus-icon-theme
              imagemagick
              fonts-jetbrains-mono
              fonts-cascadia-code
            )

  echo -e "\n${CYAN}➜ Updating package lists...${RESET}"
  sudo apt update -y >/dev/null 2>&1 && \
    echo -e "${GREEN}✔ Package lists updated${RESET}" || \
    echo -e "${RED}✘ Failed to update package lists${RESET}"

  echo -e "\n${CYAN}➜ Installing essentials...${RESET}"

  for pkg in "${packages[@]}"; do
    if dpkg -s "$pkg" &>/dev/null; then
      echo -e "${YELLOW}⚡ $pkg is already installed${RESET}"
    else
      if sudo apt install -y "$pkg" >/dev/null 2>&1; then
        echo -e "${GREEN}✔ Installed $pkg${RESET}"
      else
        echo -e "${RED}✘ Failed to install $pkg${RESET}"
      fi
    fi
  done

  echo -e "\n${CYAN}➜ Installation complete.${RESET}\n"
}
install_pkg
fc-cache -fv

# ---------------------------------------------------------------------
# # Fix Locale:
# fix_locale() {
#   if ! locale | grep -q ".UTF-8"; then
#     echo "Fixing locale to UTF-8..."
#     echo 'LANG="en_US.UTF-8"' | sudo tee /etc/default/locale
#     echo 'LC_ALL="en_US.UTF-8"' | sudo tee -a /etc/default/locale
#     sudo locale-gen en_US.UTF-8
#     sudo update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
#   else
#     echo "Locale is already set to UTF-8."
#   fi
# }
# fix_locale
#
#----------------------------i3-------------------------------------------
[ -d "$HOME/.config/i3" ] && mv "$HOME/.config/i3" "$HOME/.config/i3.bak"
cp -r "$SCRIPT_DIR/config/i3" "$HOME/.config/" && echo "Copied i3 configs"

#----------------------------Bashrc---------------------------------------
# Bash config
  [ -f "$HOME/.bashrc" ] && mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
  cp "$SCRIPT_DIR/src/bashrc" "$HOME/.bashrc" && echo "Copied bashrc"

#----------------------------Tmux----------------------------------------
# Tmux config
[ -f "$HOME/.tmux.conf" ] && mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
cp "$SCRIPT_DIR/src/tmux.conf" "$HOME/.tmux.conf"

#----------------------------Neovim--------------------------------------
# Nvim config
[ -d "$HOME/.config/nvim" ] && mv "$HOME/.config/nvim.bak"
cp -r "$SCRIPT_DIR/config/nvim" "$HOME/.config/nvim"

#---------------------------Wallpaper--------------------------------------
cp -r "$SCRIPT_DIR/src/wallpaper" "$HOME/.wallpaper"
cp "$SCRIPT_DIR/src/.fehbg" "$HOME/.fehbg"

#----------------------------Rofi, Terminator, Picom, Sublime-Text, Kitty-------------------------------------------
cp -r "$SCRIPT_DIR/config/rofi" "$HOME/.config/"
cp -r "$SCRIPT_DIR/config/terminator" "$HOME/.config/"
cp -r "$SCRIPT_DIR/config/sublime-text" "$HOME/.config/"
sudo cp -r "$SCRIPT_DIR/config/picom" "$HOME/.config/"
cp -r "$SCRIPT_DIR/config/kitty" "$HOME/.config/"
#cp -r "$SCRIPT_DIR/config/compton" "$HOME/.config/"



#---------------------------VPN Config-------------------------------------------------------------
sudo cp -r "$SCRIPT_DIR/src/vpn-config/" "/etc/"


#------------------------------Install Gaps

git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps && mkdir -p build && cd build && meson ..
ninja
sudo ninja install
cd ../..

#----------------------










 

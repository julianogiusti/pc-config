#!/bin/bash

cd && mkdir opt

sudo apt update
sudo apt upgrade -y

sudo apt install -y snapd

sudo apt install -y vim htop curl git ssh sshfs gdebi yakuake terminator blueman

sudo apt install -y zsh
cd && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# zsh plugins
sudo apt install -y fzf
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin

cp .zshrc ~/.zshrc
source ~/.zshrc

sudo apt install -y ubuntu-restricted-extras

# apps

wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

sudo snap install sublime-text --classic
sudo snap install libreoffice okular pdfarranger

# gnome settings

sudo apt install -y gnome-tweaks chrome-gnome-shell gnome-shell-extensions
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'

sudo apt clean
sudo apt autoremove --purge
#!/bin/bash

# Antes de tudo

sudo apt update
sudo apt upgrade -y

sudo apt install snapd

cd && mkdir opt

# 1. Uso pessoal: Navegador, multimídia, manipulação de imagens, mensagens, etc.

wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

sudo apt install -y ubuntu-restricted-extras

sudo snap install spotify
sudo snap install vlc

cd ~/opt
wget -c -O telegram.tar.xz https://telegram.org/dl/desktop/linux
tar -xvJf telegram.tar.xz
rm telegram.tar.xz

sudo snap install slack --classic
sudo snap install skype --classic

# 2. Desenvolvimento e outros utilitários

sudo apt install -y vim htop curl git ssh sshfs

git config --global user.name "Juliano Giusti"
git config --global user.email giustijuliano@gmail.com

ssh-keygen -t rsa -C "giustijuliano@gmail.com" -b 4096

sudo snap install sublime-text --classic
sudo snap install pycharm-community --classic
# sudo snap install code --classic

curl https://pyenv.run | bash

sudo apt-get install -y \
  make \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  wget \
  curl \
  llvm \
  libncurses5-dev \
  libncursesw5-dev \
  xz-utils \
  tk-dev \
  libffi-dev \
  liblzma-dev \
  python-openssl \
  git

exec $SHELL

sudo apt clean
sudo apt autoremove --purge

sudo reboot
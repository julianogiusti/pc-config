#!/bin/bash

# Antes de tudo

sudo apt update
sudo apt upgrade -y

sudo apt install snapd

cd
mkdir opt

# 1. Uso pessoal: Navegador, multimídia, manipulação de imagens, mensagens, etc.

wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

sudo apt install -y ubuntu-restricted-extras

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt install -y spotify-client
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

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
sudo apt update
sudo apt install -y r-base r-base-dev
R --version

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 51F523511C7028C3
sudo add-apt-repository 'deb     https://qgis.org/ubuntu-ltr bionic main'
sudo add-apt-repository 'deb-src https://qgis.org/ubuntu-ltr bionic main'
sudo apt update
sudo apt install qgis qgis-plugin-grass

sudo apt clean
sudo apt autoremove --purge
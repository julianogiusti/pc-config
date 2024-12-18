#!/bin/bash

# checar espaço usado pelo cache do apt e limpar
sudo du -sh /var/cache/apt/archives
sudo apt clean

# remover kernels antigos
sudo apt autoremove --purge

# limpar cache do pip
pip cache info
pip cache purge

# limpar flatpak
flatpak uninstall --unused
sudo flatpak repair

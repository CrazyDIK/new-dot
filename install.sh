#!/bin/bash

sudo pacman -Syyu --noconfirm

sudo pacman -Sy --noconfirm zsh git firefox eza bat stow alacritty fzf neovim npm pavucontrol waybar zip unzip thunar gvfs gvfs-fuse xdg-utils thunar-volman tumbler ffmpegthumbnailer swayimg

cd ~/.dotfiles/

stow .

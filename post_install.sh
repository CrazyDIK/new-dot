#!/usr/bin/env bash

rm -rf ~/.config/hypr
rm -rf ~/.config/kitty
rm -rf ~/.zshrc
rm -rf ~/.p10k.zsh

stow .

chsh -s $(which zsh)

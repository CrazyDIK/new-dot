 #!/usr/bin/env bash

sudo pacman -Syyu --noconfirm

sudo pacman -Sy --noconfirm zsh git firefox eza bat stow alacritty fzf neovim npm pavucontrol waybar zip unzip thunar gvfs xdg-utils thunar-volman tumbler ffmpegthumbnailer swayimg ttf-jetbrains-mono-nerd

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

./post_install.sh

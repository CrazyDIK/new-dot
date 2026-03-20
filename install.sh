 #!/usr/bin/env bash

my_name="$(whoami)"

sudo sed 's/5/15/' /etc/pacman.conf

sudo pacman -Syyu --noconfirm

sudo pacman -Sy --noconfirm zsh git firefox eza bat stow alacritty fzf neovim npm pavucontrol waybar zip unzip thunar gvfs xdg-utils thunar-volman tumbler ffmpegthumbnailer swayimg ttf-jetbrains-mono-nerd rhythmbox swaync

sh ./omz.sh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

rm -rf ~/.config/hypr
rm -rf ~/.config/kitty
rm -rf ~/.zshrc
rm -rf ~/.p10k.zsh

sed -i '/^monitor=/c\monitor=, preferred, auto, auto' ./.config/hypr/hyprland.conf

stow .

sudo chown -R $my_name:$my_name /home/$my_name/.local

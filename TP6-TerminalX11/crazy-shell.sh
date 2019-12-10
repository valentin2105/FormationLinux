#! /bin/bash

sudo apt-get update && sudo apt-get -y install tmux git vim ccze zsh curl 

## Oh my ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

## zsh-autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

google-chrome https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

echo "----------------------------------------------------------------------"
echo "Choisissez votre thème OhMyZsh et changez le dans votre fichier .zshrc"
echo "----------------------------------------------------------------------"

#!/bin/bash
# [refence](https://github.com/lepture/dotfiles/blob/master/bootstrap.sh)

cd $(dirname "$0")

link() {
    if [ ! -h $HOME/.$1 ]; then
        ln -s "`pwd`/$1" "$HOME/.$1"
    fi
}

linkfish() {
    if [ ! -d $HOME/.config/fish]; then
        ln -s "`pwd`/config.fish" "$HOME/.config/fish/config.fish"
    fi
}

#link bashrc

echo "setup zsh >>>"
if hash zsh 2>/dev/null; then
    echo "chsh -s `which zsh`"

    if [ ! -d $HOME/.oh-my-zsh ]; then
        # git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    fi
else
    echo "please install zsh."
fi
#link alias
ln -s "`pwd`/zsh/alias" "$HOME/.alias"
#link zshrc
ln -s "`pwd`/zsh/zshrc" "$HOME/.zshrc"

echo "init homebrew >>>"
if hash brew 2>/dev/null; then
    echo "brew already installed"
else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install caskroom/cask/brew-cask
fi

echo "init vim >>>"
if hash mvim 2>/dev/null; then
    echo "macvim already installed"
else
    brew install macvim
    brew linkapps macvim
fi
if [ ! -d vim/bundle/vundle ]; then
    git clone https://github.com/gmarik/vundle.git vim/bundle/vundle
fi
#link vim
#link vimrc
ln -s "`pwd`/vim/vimrc" "$HOME/.vimrc"
vim +BundleInstall +qall

echo "init python env >>>"
if hash pip 2>/dev/null; then
    echo "pip already installed"
else
    sudo easy_install pip
fi
sudo pip install dbgp
sudo pip install vim-debug 
sudo pip install pep8 
#sudo pip install flake8

echo "init node >>>"
if hash node 2>/dev/null; then
    echo "node already installed"
else
    brew install node
fi

#install npm global package
npm install -g grunt-cli
npm install -g bower
npm install -g less
npm install -g jshint

echo "init git >>>"
#link gitconfig
ln -s "`pwd`/git/gitconfig" "$HOME/.gitconfig"

#link tmux.conf

echo "init other tools >>>"
echo "tig >>>"
if hash tig 2>/dev/null; then
    echo "tig already installed"
else
    brew install tig
fi
echo "tree >>>"
if hash tree 2>/dev/null; then
    echo "tree already installed"
else
    brew install tree
fi

#linkfish


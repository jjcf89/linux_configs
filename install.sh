#!/bin/sh

# Set cwd to location of script
cd $(dirname ${BASH_SOURCE[0]} )
BASE=$PWD

sudo true

cd ~/

HOME_FILES='.bashrc .bash_aliases .completion .gitconfig .vimrc'

for f in $HOME_FILES; do
    echo Copying $BASE/$f to .
    #If not a symlink
    if [ ! -L $f ]; then
        cp -vs --suffix=.bak $BASE/$f .
    fi
done

sudo apt-get install -y vim git subversion
echo Copying .vim directory
# If not a symlink and directory exists
if [ ! -L .vim ] && [ -d .vim ]; then
    mv -v .vim .vim.bak
fi
# If directory doesnt exist
if [ ! -d .vim ]; then
    ln -vs $BASE/.vim .vim
fi
# Configure vim with git ignore file
git config --global core.excludesfile $BASE/C.gitignore

sudo apt-get install -y ccache
# If not a symlink
[ ! -L /usr/lib/ccache/arm-arago-linux-gnueabi-gcc ] && (
cd /usr/lib/ccache/
sudo ln -s ../../bin/ccache arm-arago-linux-gnueabi-g++
sudo ln -s ../../bin/ccache arm-arago-linux-gnueabi-gcc
sudo ln -s ../../bin/ccache arm-arago-linux-gnueabi-cpp
sudo ln -s ../../bin/ccache arm-angstrom-linux-gnueabi-cpp
sudo ln -s ../../bin/ccache arm-angstrom-linux-gnueabi-gcc
sudo ln -s ../../bin/ccache arm-angstrom-linux-gnueabi-g++
)

cd $BASE
git submodule update --init --recursive

sudo apt-get install -y build-essential cmake python-dev
(
    cd .vim/bundle/YouCompleteMe
    ./install.sh --clang-completer
)

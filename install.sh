#!/bin/sh

BASE=$PWD

cd ~/

HOME_FILES='.bashrc .gitconfig .vimrc'

for f in $HOME_FILES; do
    echo Copying $BASE/$f to .
    #If not a symlink
    if [ ! -L $f ]; then
        cp -vs --suffix=.bak $BASE/$f .
    fi
done

echo Copying .vim directory
# If not a symlink and directory exists
if [ ! -L .vim ] && [ -d .vim ]; then
    mv -v .vim .vim.bak
fi
# If directory doesnt exist
if [ ! -d .vim ]; then
    ln -vs $BASE/.vim .vim
fi

sudo apt-get install ccache
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


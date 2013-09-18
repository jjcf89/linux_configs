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

#!/bin/sh

sudo apt-get install python

./install_fonts.sh

cd powerline-shell/

cp config.py.dist config.py
./install.py

ln -fvs $PWD/powerline-shell.py ~/.powerline-shell.py

#!/bin/sh

mkdir -p ~/fonts
mkdir -p ~/.config/fontconfig/conf.d

cp PowerlineSymbols.otf ~/fonts
cp 10-powerline-symbols.conf ~/.config/fontconfig/conf.d

sudo fc-cache -vf ~/.fonts/

#!/bin/bash

# https://neovim.io/
mkdir -p ~/.local/bin
rm -f ~/.local/bin/nvim.appimage ~/.local/bin/nvim

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
mv nvim.appimage ~/.local/bin/nvim.appimage
chmod u+x ~/.local/bin/nvim.appimage
ln -s ~/.local/bin/nvim.appimage ~/.local/bin/nvim

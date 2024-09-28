# Install

## linux/mac:

git clone git@github.com:zy9306/nvim.git ~/.config/nvim

## win

git clone git@github.com:zy9306/nvim.git "$env:LOCALAPPDATA\nvim"

## build

mac m1 build telescope-fzf-native:
```
# 下载 macos-universal.tar.gz
# https://github.com/Kitware/CMake/releases/tag/v3.30.3
cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim
arch -arm64 /path/cmake-3.30.3-macos-universal/CMake.app/Contents/bin/cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release
```

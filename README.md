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

## build tree-sitter-module

mac m1 启用 rosetta 后 TSInstall 会编译出 x86 的, 无法使用, 需要手动编译 arm64 的

```
git clone git@github.com:casouri/tree-sitter-module.git

arch -arm64 ./build.sh <language>

mv ./dist/libtree-sitter-<language>.dylib ~/.local/share/nvim/lazy/nvim-treesitter/parser/<language>.so
```

正常安装

`:TSInstall <language>`

## build avante.nvim

mac m1
```
cd ~/.local/share/nvim/lazy/avante.nvim
arch -arm64 make
```

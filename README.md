# Install

## linux/mac:

git clone git@github.com:zy9306/nvim.git ~/.config/nvim

## win

git clone git@github.com:zy9306/nvim.git "$env:LOCALAPPDATA\nvim"

## paths

- plugins: ~/.local/share/nvim/lazy
- treesitter: ~/.local/share/nvim/lazy/nvim-treesitter


## lsp

https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers

e.g.

`MasonInstall pyright`

or 

`LspInstall pyright`

## treesitter

e.g.

`TSInstall python`


## 如果在 m1 下出现编译动态库架构不对的问题

确保 `arch` 命令输出的是 `arm64`

如果使用的是 x86_64 的 tmux, 增加以下配置

`set-option -g default-command "arch -arch arm64 /bin/zsh"`


正常情况下就能解决了, 如果还是有问题, 可以手动编译一些需要的动态库:

telescope-fzf-native:

```
# 下载 macos-universal.tar.gz
# https://github.com/Kitware/CMake/releases/tag/v3.30.3
cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim
arch -arm64 /path/cmake-3.30.3-macos-universal/CMake.app/Contents/bin/cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release
```

avante:

```
cd ~/.local/share/nvim/lazy/avante.nvim
arch -arm64 make
```

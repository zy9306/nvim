# Install

install neovim latest stable version from https://github.com/neovim/neovim/releases

```
curl -L -O https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-macos-arm64.tar.gz
tar zxvf nvim-macos-arm64.tar.gz
mv /opt/nvim /opt/nvim.bak.$(date +%s) || true
mv nvim-macos-arm64.tar.gz /opt/nvim
rm -f nvim-macos-arm64.tar.gz
```

## linux/mac:

git clone git@github.com:zy9306/nvim.git ~/.config/nvim

## win

git clone git@github.com:zy9306/nvim.git "$env:LOCALAPPDATA\nvim"

## paths

- plugins: ~/.local/share/nvim/lazy
- treesitter: ~/.local/share/nvim/lazy/nvim-treesitter


## lsp

直接执行 `LspInstall` 会列出当前文件类型支持的 lsp, 选择需要的即可

或手动安装

`MasonInstall pyright`

or 

`LspInstall pyright`

## treesitter

e.g.

`TSInstall python`

# Neovim Keybindings

这份清单按类别整理了当前配置里**显式写在仓库中的键位**，包括：

- `vim.keymap.set(...)`
- `vim.api.nvim_set_keymap(...)`
- Lazy 插件 `keys = { ... }`
- 一些插件配置里的局部 `keymaps` / `mappings`

说明：

- `leader` 是空格键，所以 `<leader>ff` 等价于 `Space ff`
- 这份文档主要覆盖你自己配置里声明出来的映射
- 某些插件还保留了它们的上游默认键位（例如 `blink.cmp` 的 `preset = "default"`、`nvim-tree` 的 `default_on_attach`），这里不展开它们全部默认表
- 同一个按键如果在不同 buffer / mode / 插件里重复定义，会在对应条目里注明

## 1. Core / Base

| Key | Mode | Action |
| --- | --- | --- |
| `<C-s>` | `n,v` | 进入 `/` 搜索 |
| `<C-s>` | `i` | 退出插入并进入 `/` 搜索 |
| `<leader>$` | `n` | 切换 `wrap` |
| `<C-]>` | `n,v` | 循环把当前行放到屏幕中间 / 顶部 / 底部 |
| `<C-I>` | `n` | 显式保留默认 `<C-I>` 行为 |

## 2. Disabled / Overridden Defaults

| Key | Mode | Action |
| --- | --- | --- |
| `;` | `n` | 禁用 |
| `f` | `n` | 禁用 |
| `J` | `n,x` | 禁用 |
| `K` | `n,x` | 禁用 |
| `L` | `n,x` | 禁用 |
| `H` | `n,x` | 禁用 |
| `C` | `n,x` | 禁用 |
| `<ScrollWheelRight>` | `all` | 禁用 |
| `<MiddleMouse>` | `n` | 禁用 |
| `<2-MiddleMouse>` | `n` | 禁用 |
| `<3-MiddleMouse>` | `n` | 禁用 |
| `<4-MiddleMouse>` | `n` | 禁用 |
| `<RightMouse>` | `n,t` | 禁用右键点击（交给 gesture 使用） |

## 3. Insert / Command-Line Editing

| Key | Mode | Action |
| --- | --- | --- |
| `<C-B>` | `i` | 光标左移 |
| `<C-F>` | `i` | 光标右移 |
| `<C-_>` | `i` | 插入 undo break |
| `<C-B>` | `c` | 光标左移 |
| `<C-F>` | `c` | 光标右移 |
| `<C-A>` | `c` | 跳到命令行开头 |
| `<C-E>` | `c` | 跳到命令行结尾 |
| `p` | `x` | 粘贴时不覆盖默认寄存器 |

## 4. Clipboard / Path Helpers

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>yP` | `n` | 复制当前文件绝对路径 |
| `<leader>yp` | `n` | 复制当前文件相对路径 |
| `<leader>yf` | `n` | 复制当前文件名 |
| `<leader>yl` | `n,x` | 复制相对路径 + 当前行 / 选中行范围 |
| `<leader>yL` | `n,x` | 复制绝对路径 + 当前行 / 选中行范围 |

## 5. Window / Buffer / Navigation

| Key | Mode | Action |
| --- | --- | --- |
| `<C-Up>` | `n` | 高度 -2 |
| `<C-Down>` | `n` | 高度 +2 |
| `<C-Left>` | `n` | 宽度 -2 |
| `<C-Right>` | `n` | 宽度 +2 |
| `<A-Right>` | `n` | 下一个 buffer |
| `<A-Left>` | `n` | 上一个 buffer |
| `<C-S-h>` | `n,t` | 跳到左侧窗口 / split |
| `<C-S-j>` | `n,t` | 跳到下侧窗口 / split |
| `<C-S-k>` | `n,t` | 跳到上侧窗口 / split |
| `<C-S-l>` | `n,t` | 跳到右侧窗口 / split |
| `<Tab>` | `n` | `:EagleWin` |

## 6. File Finding / Search / Pickers

| Key | Mode | Action |
| --- | --- | --- |
| `<leader><leader>` | `n` | Telescope resume |
| `<leader>ff` | `n,v` | Telescope find files |
| `<leader>S` | `n,v` | Telescope live grep（当前单词 / 选区） |
| `<leader>s` | `n,v` | 当前 buffer 内搜索 |
| `<leader>b` | `n,v` | Telescope buffers |
| ``<C-`>`` | `n,v,t` | Telescope buffers |
| `<leader>fp` | `n` | Telescope file browser |
| `<leader>x` | `n` | Telescope cmdline |
| `<leader><C-p>` | `n` | Telescope projects |
| `Space + \`` | `n` | Telescope quickfix history |

### Telescope 内部按键

| Key | Context | Action |
| --- | --- | --- |
| `<C-d>` | Telescope `buffers` / insert | 删除 buffer 并移到顶部 |
| `<C-k>` | `live_grep_args` / insert | 给搜索词加引号 |
| `<C-i>` | `live_grep_args` / insert | 给搜索词加引号并追加 ` --iglob ` |

## 7. Explorer / File Managers / Tree / Outline / Quickfix

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>jj` | `n` | 打开 Oil（当前文件所在目录） |
| `<leader>jJ` | `n` | 打开 Oil（当前工作目录） |
| `<leader>jr` | `n` | 恢复上一次 Yazi 会话 |
| `-` | `n` | 打开 Oil（父目录） |
| `<F9>` | `n` | 切换 Neo-tree buffers |
| `<leader>ft` | `n` | 切换 NvimTree |
| `<leader>o` | `n` | 切换 Outline |
| `<leader>Q` | `n` | 切换 quickfix（quicker.nvim） |

### Neo-tree 内部按键

| Key | Context | Action |
| --- | --- | --- |
| `E` | Neo-tree window | 切到 filesystem source |
| `B` | Neo-tree window | 切到 buffers source |
| `G` | Neo-tree window | 切到 git status source |
| `D` | Neo-tree filesystem | 删除 |
| `d` | Neo-tree buffers | 删除 buffer |
| `bd` | Neo-tree filesystem / buffers | 禁用默认删除 |

### NvimTree 内部按键

| Key | Context | Action |
| --- | --- | --- |
| `<C-t>` | NvimTree buffer | 回到父目录 / root |
| `?` | NvimTree buffer | 显示帮助 |

### Oil 内部按键

| Key | Context | Action |
| --- | --- | --- |
| `<C-c>` | Oil buffer / `n` | 映射为 `<Esc>` |
| `<C-c>` | Oil buffer / `i` | 映射为 `<Esc>` |
| `<C-p>` | Oil buffer | 打开 / 关闭预览窗格 |
| `q` | Oil buffer / `n` | 关闭 Oil |
| `gd` | Oil buffer | 切换文件详情列 |

### Outline / Quickfix 内部按键

| Key | Context | Action |
| --- | --- | --- |
| `<CR>` | Outline buffer | 跳转到符号位置 |
| `<LeftRelease>` | Outline buffer | 鼠标跳转到符号位置 |
| `>` | quickfix buffer | 展开上下文 |
| `<` | quickfix buffer | 折叠上下文 |
| `<Tab>` | quickfix buffer | 打开条目并返回原窗口 |

## 8. LSP / Diagnostics / Code Navigation

| Key | Mode | Action |
| --- | --- | --- |
| `gd` | `n` | 跳到 definition |
| `gi` | `n` | 跳到 implementation |
| `gr` | `n` | 跳到 references |
| `gR` | `n` | rename |
| `gD` | `n` | goto-preview definition |
| `gT` | `n` | goto-preview type definition |
| `gI` | `n` | goto-preview implementation |
| `<leader>!!` | `n` | 打开当前诊断浮窗 |
| `<leader>!e` | `n` | Telescope diagnostics（只看 ERROR） |
| `<leader>!a` | `n` | Telescope diagnostics（全部） |
| `<leader>ld` | `n` | Telescope LSP definitions |
| `<leader>lr` | `n` | Telescope LSP references |
| `<leader>li` | `n` | Telescope LSP implementations |
| `<leader>ls` | `n` | Telescope document symbols |
| `<leader>la` | `n` | code action |
| `<C-k>` | `n,i` | 切换 `lsp_signature` 浮窗 |
| `<leader>k` | `n` | `vim.lsp.buf.signature_help()` |

### 预览窗口局部按键

| Key | Context | Action |
| --- | --- | --- |
| `q` | goto-preview 浮窗 | 关闭浮窗 |
| `<Esc>` | goto-preview 浮窗 | 关闭浮窗 |

## 9. Git / Undo / History / Replace / Format

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>lg` | `n` | LazyGit |
| `<leader>u` | `n` | 切换 Undotree |
| `<leader>Y` | `n,v` | 打开 Yank history |
| `<leader>%%` | `n` | 打开 grug-far |
| `<leader>%s` | `n` | 切换 Spectre |
| `<leader>F` | `n` | 格式化当前 buffer |
| `<leader>?` | `n` | 打开 which-key |

### Yanky 改写后的复制 / 粘贴

| Key | Mode | Action |
| --- | --- | --- |
| `y` | `n,x` | 使用 Yanky yank |
| `p` | `n,x` | Yanky put after |
| `P` | `n,x` | Yanky put before |
| `gp` | `n,x` | Yanky gput after |
| `gP` | `n,x` | Yanky gput before |

## 10. Editing / Motion / Selection

| Key | Mode | Action |
| --- | --- | --- |
| `<A-j>` | `n` | 下移当前行 |
| `<A-k>` | `n` | 上移当前行 |
| `<A-h>` | `n` | 左移字符 |
| `<A-l>` | `n` | 右移字符 |
| `<A-j>` | `v` | 下移选区 |
| `<A-k>` | `v` | 上移选区 |
| `<A-h>` | `v` | 左移选区 |
| `<A-l>` | `v` | 右移选区 |
| `zR` | `n` | 打开所有折叠 |
| `zM` | `n` | 关闭所有折叠 |
| `vv` | `n` | Treesitter 增量选区：开始 / 向外扩展 |
| `vV` | `n` | Treesitter 增量选区：收缩 |

### Flash

| Key | Mode | Action |
| --- | --- | --- |
| `s` | `n,x,o` | Flash jump |
| `S` | `n,x,o` | Flash Treesitter |
| `r` | `o` | Remote Flash |
| `R` | `o,x` | Treesitter Search |
| `<C-s>` | `c` | 切换 Flash Search |

### Completion / AI

| Key | Context | Action |
| --- | --- | --- |
| `<CR>` | `blink.cmp` | `accept`, 失败时 `fallback` |
| `<C-l>` | Copilot suggestion | 接受整条建议 |
| `<C-]>` | Copilot suggestion | dismiss |
| `<Tab>` | `i` | Copilot 可见时接受一个 word，否则插入 Tab |
| `<C-n>` | `i` | Copilot 可见时下一条，否则保留原 `<C-n>` |
| `<C-p>` | `i` | Copilot 可见时上一条，否则保留原 `<C-p>` |
| `<C-c>` | `i` | dismiss Copilot 并退出插入模式 |

### Text-case

| Key | Context | Action |
| --- | --- | --- |
| `gs...` | text-case | 所有 text-case 子映射都挂在 `gs` 前缀下 |

## 11. Multi-cursor / Marks / Bookmarks

| Key | Mode | Action |
| --- | --- | --- |
| `<A-Up>` | `n` | 向上加一个 cursor |
| `<A-Down>` | `n` | 向下加一个 cursor |
| `<C-m>` | `v` | 为当前匹配添加 cursor |
| `<C-s>` | `v` | 跳过当前匹配 |
| `<A-Left>` | `n,v` | multicursor 下一个 cursor |
| `<A-Right>` | `n,v` | multicursor 上一个 cursor |
| `<C-LeftMouse>` | `n,v` | 鼠标处理 multicursor |
| `<Esc>` | `n` | 启用 / 清空 multicursor |
| `<C-c>` | `n` | 启用 / 清空 multicursor |
| `I` | `v` | multicursor insertVisual |
| `A` | `v` | multicursor appendVisual |
| `M` | `v` | multicursor matchCursors |
| `ma` | `n` | 创建 vmark |
| `md` | `n` | 删除当前 vmark |
| `mo` | `n` | 递归打开所有 vmark 到 quickfix |
| `me` | `n` | 输出当前 vmark 文本 |
| `mk` | `n,v,o` | 上一个 vmark |
| `mj` | `n,v,o` | 下一个 vmark |
| `<leader>ma` | `n` | 添加 bookmark |
| `<leader>mm` | `n` | 显示 bookmarks |
| `<leader>me` | `n` | 打开 bookmarks 文件 |

## 12. Terminal

| Key | Mode | Action |
| --- | --- | --- |
| `<F7>` | `n` | 新建 terminal，并可命名 buffer |
| `<C-t>` | `n,t` | 切换 betterTerm |
| `<F6>` | `n,t` | 切换 betterTerm |

### betterTerm 内部按键

| Key | Context | Action |
| --- | --- | --- |
| `<C-;>` | betterTerm | 新建 terminal tab |
| `<A-$tab>` | betterTerm | 跳转 terminal tab |

### Terminal buffer 局部按键

| Key | Context | Action |
| --- | --- | --- |
| `q` | terminal buffer / `n,v` | 回到 terminal insert mode |

## 13. Mouse Gestures

| Key | Mode | Action |
| --- | --- | --- |
| `<RightDrag>` | `n,t` | 开始记录手势 |
| `<RightRelease>` | `n,t` | 结束并执行手势 |

### 已注册的手势

| Gesture | Action |
| --- | --- |
| `Down` | 跳到文件底部 |
| `Up` | 跳到文件顶部 |
| `Up, Right` | 下一个 buffer |
| `Up, Left` | 上一个 buffer |
| `Left` | 后退（`<C-o>`） |
| `Right` | 前进（`<C-i>`） |
| `Down, Right` | 关闭当前窗口 |
| `Down, Right, Left` | 删除当前 buffer |
| `Down, Right, Up` | 删除其他 buffer |
| `Up, Right, Down` | 保存文件 |
| `Right ... Up` | 关闭手势经过的窗口 |

## 14. GUI / Environment-Specific

### Neovide only

| Key | Mode | Action |
| --- | --- | --- |
| `<D-v>` | `all` | 粘贴系统剪贴板 |
| `<D-v>` | `!` | 插入 / 命令行模式粘贴系统剪贴板 |
| `<D-v>` | `t` | terminal 粘贴系统剪贴板 |
| `<D-v>` | `v` | visual 粘贴系统剪贴板 |

### VSCode mode only

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>ff` | `n` | VSCode quick open |
| `<leader>b` | `n` | VSCode quick open |
| `<leader>x` | `n` | VSCode command palette |
| `<leader>w` | `n` | VSCode save |
| `<leader>S` | `n` | VSCode find in files |

## 15. Notes on Collisions / Scope

- `<A-Left>` / `<A-Right>` 同时被 buffer 切换和 multicursor 使用；实际效果取决于当前 mode 与加载时机
- `<C-t>` 既是全局 betterTerm 切换，也是 `nvim-tree` buffer 里的局部按键
- `<Tab>` 全局 normal 模式会触发 `:EagleWin`，但在 quickfix buffer 里有局部覆盖；insert 模式下又被 Copilot 使用
- `<C-c>` 在不同上下文里分别用于 Copilot、multicursor、Oil buffer
- `q` 在 goto-preview 浮窗和 terminal buffer 中都有局部定义

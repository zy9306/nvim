vim.cmd([[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.Paste
  aunmenu PopUp.Select\ All
  aunmenu PopUp.-1-

  amenu PopUp.Buffers <Cmd>:lua require("telescope.builtin").buffers(require('telescope.themes').get_ivy())<CR>
  amenu PopUp.FileFormat <Cmd>:set fileformat?<CR>

  amenu PopUp.-100- <Nop>
  amenu PopUp.Split\ H <Cmd>:split<CR>
  amenu PopUp.Split\ V <Cmd>:vsplit<CR>

  amenu PopUp.-110- <Nop>
  amenu PopUp.Only <Cmd>:only<CR>
  amenu PopUp.Bdelete <Cmd>:Bdelete!<CR>
  amenu PopUp.Bdothers <Cmd>:Bdothers<CR>

  amenu PopUp.-120- <Nop>
  amenu PopUp.Quit <Cmd>:q!<CR>
]])

vim.o.backup = true
vim.o.backupdir = vim.fn.expand("~/.config/nvim/backup//")
vim.o.backupext = "-vimbackup"
vim.o.writebackup = true

vim.cmd([[
augroup BackupControl
  autocmd!
  autocmd BufWritePre * lua MaybeBackup(vim.fn.expand('<afile>'))
augroup END
]])

function MaybeBackup(file)
	local filesize = vim.fn.getfsize(file)
	if filesize > 5 * 1024 * 1024 then
		vim.o.writebackup = false
	else
		vim.o.writebackup = true
		DeleteOldBackups(file)
	end
end

function DeleteOldBackups(file)
	local backupdir = vim.fn.expand(vim.o.backupdir)
	local filename = vim.fn.fnamemodify(file, ":t")
	local backups = vim.fn.split(vim.fn.glob(backupdir .. filename .. "-*"), "\n")
	if #backups > 20 then
		vim.fn.delete(backups[1])
	end
end

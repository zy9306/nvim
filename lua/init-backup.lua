-- vim.o.backup = false
vim.o.backupdir = vim.fn.expand("~/.config/nvim/backup//")
vim.o.backupext = "-vimbackup"
-- vim.o.writebackup = false

vim.cmd([[
augroup BackupControl
  autocmd!
  autocmd BufWritePre * lua maybe_backup(vim.fn.expand('<afile>'))
augroup END
]])

function maybe_backup(file)
    local filesize = vim.fn.getfsize(file)
    if filesize <= 5 * 1024 * 1024 then
        local timestamp = os.date("%Y%m%d%H%M%S")
        local full_path = vim.fn.fnamemodify(file, ":p")
        local sanitized_path = full_path:gsub("[/\\]", "-")
        local sanitized_path_no_leading_dash = sanitized_path:gsub("^%-", "")
        local backup_file =
            string.format("%s%s-%s%s", vim.o.backupdir, sanitized_path_no_leading_dash, timestamp, vim.o.backupext)
        vim.fn.writefile(vim.fn.readfile(file), backup_file)
        delete_old_backups(file)
    end
end

function delete_old_backups(file)
    local backupdir = vim.fn.expand(vim.o.backupdir)
    local full_path = vim.fn.fnamemodify(file, ":p")
    local sanitized_path = full_path:gsub("[/\\]", "-")
    local sanitized_path_no_leading_dash = sanitized_path:gsub("^%-", "")
    local backups = vim.fn.split(vim.fn.glob(backupdir .. sanitized_path_no_leading_dash .. "-*"), "\n")
    while #backups > 20 do
        vim.fn.delete(backups[1])
        table.remove(backups, 1)
    end
end

local M = {}

local function trim(value)
    return (value:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function is_escaped(value, index)
    local backslashes = 0
    local pos = index - 1

    while pos > 0 and value:sub(pos, pos) == "\\" do
        backslashes = backslashes + 1
        pos = pos - 1
    end

    return backslashes % 2 == 1
end

local function has_pipe(value)
    for index = 1, #value do
        if value:sub(index, index) == "|" and not is_escaped(value, index) then
            return true
        end
    end

    return false
end

local function split_row(line)
    local cells = {}
    local start = 1

    for index = 1, #line do
        if line:sub(index, index) == "|" and not is_escaped(line, index) then
            table.insert(cells, trim(line:sub(start, index - 1)))
            start = index + 1
        end
    end

    table.insert(cells, trim(line:sub(start)))

    if line:match("^%s*|") and cells[1] == "" then
        table.remove(cells, 1)
    end

    if line:match("|%s*$") and cells[#cells] == "" then
        table.remove(cells)
    end

    return cells
end

local function parse_delimiter_cell(cell)
    cell = trim(cell)

    if not cell:match("^:?-+:?$") then
        return nil
    end

    local left = cell:sub(1, 1) == ":"
    local right = cell:sub(-1) == ":"

    if left and right then
        return "center"
    end

    if right then
        return "right"
    end

    if left then
        return "left"
    end

    return "default"
end

local function parse_delimiter_row(cells)
    if #cells == 0 then
        return nil
    end

    local aligns = {}

    for index, cell in ipairs(cells) do
        local align = parse_delimiter_cell(cell)

        if not align then
            return nil
        end

        aligns[index] = align
    end

    return aligns
end

local function delimiter_min_width(align)
    if align == "center" then
        return 5
    end

    if align == "left" or align == "right" then
        return 4
    end

    return 3
end

local function display_width(value)
    return vim.fn.strdisplaywidth(value)
end

local function pad(value, width, align)
    local padding = math.max(width - display_width(value), 0)

    if align == "right" then
        return string.rep(" ", padding) .. value
    end

    if align == "center" then
        local left = math.floor(padding / 2)
        local right = padding - left
        return string.rep(" ", left) .. value .. string.rep(" ", right)
    end

    return value .. string.rep(" ", padding)
end

local function delimiter_cell(width, align)
    if align == "center" then
        return ":" .. string.rep("-", width - 2) .. ":"
    end

    if align == "right" then
        return string.rep("-", width - 1) .. ":"
    end

    if align == "left" then
        return ":" .. string.rep("-", width - 1)
    end

    return string.rep("-", width)
end

local function format_row(cells, widths, aligns, is_delimiter)
    local formatted = {}

    for column = 1, #widths do
        local align = aligns[column]

        if is_delimiter then
            formatted[column] = delimiter_cell(widths[column], align)
        else
            formatted[column] = pad(cells[column] or "", widths[column], align)
        end
    end

    return "| " .. table.concat(formatted, " | ") .. " |"
end

function M.format_lines(lines)
    local rows = {}
    local delimiter_index = nil
    local aligns = nil
    local column_count = 0

    for index, line in ipairs(lines) do
        rows[index] = split_row(line)
        column_count = math.max(column_count, #rows[index])

        if not delimiter_index then
            local parsed_aligns = parse_delimiter_row(rows[index])

            if parsed_aligns then
                delimiter_index = index
                aligns = parsed_aligns
            end
        end
    end

    if not delimiter_index then
        return nil, "No markdown table delimiter row found"
    end

    for column = 1, column_count do
        aligns[column] = aligns[column] or "default"
    end

    local widths = {}

    for column = 1, column_count do
        widths[column] = delimiter_min_width(aligns[column])
    end

    for row_index, cells in ipairs(rows) do
        if row_index ~= delimiter_index then
            for column = 1, column_count do
                widths[column] = math.max(widths[column], display_width(cells[column] or ""))
            end
        end
    end

    local formatted = {}

    for row_index, cells in ipairs(rows) do
        formatted[row_index] = format_row(cells, widths, aligns, row_index == delimiter_index)
    end

    return formatted
end

function M.format_range(start_line, end_line)
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local formatted, err = M.format_lines(lines)

    if not formatted then
        vim.notify(err, vim.log.levels.WARN)
        return false
    end

    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, formatted)
    return true
end

local function is_table_line(line)
    return line ~= "" and has_pipe(line)
end

function M.format_current_table()
    local current = vim.api.nvim_win_get_cursor(0)[1]
    local line_count = vim.api.nvim_buf_line_count(0)
    local current_line = vim.api.nvim_buf_get_lines(0, current - 1, current, false)[1] or ""

    if not is_table_line(current_line) then
        vim.notify("Cursor is not on a markdown table line", vim.log.levels.WARN)
        return false
    end

    local start_line = current
    local end_line = current

    while start_line > 1 do
        local line = vim.api.nvim_buf_get_lines(0, start_line - 2, start_line - 1, false)[1] or ""

        if not is_table_line(line) then
            break
        end

        start_line = start_line - 1
    end

    while end_line < line_count do
        local line = vim.api.nvim_buf_get_lines(0, end_line, end_line + 1, false)[1] or ""

        if not is_table_line(line) then
            break
        end

        end_line = end_line + 1
    end

    return M.format_range(start_line, end_line)
end

function M.setup(opts)
    opts = opts or {}

    local keymap = opts.keymap or "<leader>mt"
    local group = vim.api.nvim_create_augroup("MarkdownTableFormat", { clear = true })

    vim.api.nvim_create_user_command("MarkdownTableFormat", function(command)
        if command.range == 2 then
            M.format_range(command.line1, command.line2)
            return
        end

        M.format_current_table()
    end, {
        desc = "Format current markdown table",
        range = true,
    })

    if keymap ~= false then
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            pattern = "markdown",
            callback = function(event)
                vim.keymap.set("n", keymap, M.format_current_table, {
                    buffer = event.buf,
                    desc = "Format markdown table",
                    silent = true,
                })
            end,
        })
    end
end

return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        init = function()
            M.setup()
        end,
    },
}

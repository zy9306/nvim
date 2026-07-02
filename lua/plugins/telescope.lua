return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            telescope.setup({
                defaults = {
                    -- 背景透明度
                    winblend = 15,
                    mappings = {
                        i = {
                            ["<C-c>"] = actions.close,
                        },
                        n = {
                            ["<Esc>"] = actions.close,
                            ["<C-c>"] = actions.close,
                            ["q"] = actions.close,
                        },
                    },
                    layout_config = {
                        prompt_position = "top",
                    },
                    sorting_strategy = "ascending",
                    preview = { hide_on_startup = false },
                },
                pickers = {
                    find_files = {
                        find_command = { "fd", "--type", "f", "--hidden", "--follow", "--no-ignore-vcs" },
                    },
                    buffers = {
                        ignore_current_buffer = true,
                        sort_mru = true,
                        sort_lastused = true,
                        mappings = {
                            i = {
                                ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                            },
                        },
                    },
                    diagnostics = {
                        layout_config = {
                            prompt_position = "top",
                        },
                        sorting_strategy = "ascending",
                    },
                },
            })

            --- function START
            local function normalize_live_grep_default_text(text)
                text = vim.trim(text or "")
                text = text:gsub("\r\n", "\n"):gsub("\r", "\n"):gsub("\n", "\\n")
                return text
            end

            local function quote_rg_arg(text)
                return '"' .. text:gsub('"', '\\"') .. '"'
            end

            local function build_live_grep_default_text(text)
                text = normalize_live_grep_default_text(text)
                if text == "" then
                    return text
                end

                if text:match("^[-\"']") then
                    return "-e " .. quote_rg_arg(text)
                end

                return text
            end

            local function live_grep_args(opts)
                if vim.fn.executable("rg") == 0 then
                    vim.notify("ripgrep (rg) not found; Telescope live grep is unavailable", vim.log.levels.ERROR)
                    return
                end

                opts = opts or {}
                opts.default_text = build_live_grep_default_text(opts.default_text)
                opts.additional_args = opts.additional_args
                    or function()
                        return { "--multiline" }
                    end

                require("telescope").extensions.live_grep_args.live_grep_args(opts)
            end

            function get_current_word_or_selection()
                local search_text = ""
                if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "" then
                    vim.cmd('normal! "vy')
                    search_text = vim.fn.getreg("v")
                else
                    -- search_text = vim.fn.expand("<cword>")
                end
                return search_text
            end

            function global_search_current_word_or_selection()
                local search_text = get_current_word_or_selection()
                -- builtin.live_grep({ default_text = search_text })
                live_grep_args({
                    default_text = search_text,
                    theme = "ivy",
                    preview = { hide_on_startup = false },
                })
            end

            function buffer_search_current_word_or_selection()
                local search_text = get_current_word_or_selection()
                -- builtin.current_buffer_fuzzy_find({ default_text = search_text })
                live_grep_args({
                    default_text = search_text,
                    search_dirs = { vim.fn.expand("%:p") },
                    theme = "ivy",
                    preview = { hide_on_startup = false },
                })
            end
            --- function END

            --- key map START
            vim.keymap.set({ "n" }, "<leader><leader>", function()
                require("telescope.builtin").resume()
            end, { desc = "snacks resume" })

            vim.keymap.set({ "n", "v" }, "<leader>ff", function()
                require("telescope.builtin").find_files(require("telescope.themes").get_ivy({}))
            end, { desc = "Find Files" })

            vim.keymap.set({ "n", "v" }, "<leader>S", global_search_current_word_or_selection, { desc = "Live Grep" })

            vim.keymap.set({ "n", "v" }, "<leader>b", function()
                require("telescope.builtin").buffers(require("telescope.themes").get_ivy({}))
            end, { desc = "Buffers" })

            vim.keymap.set({ "n", "v", "t" }, "<C-`>", function()
                require("telescope.builtin").buffers(require("telescope.themes").get_ivy({}))
            end, { desc = "Buffers" })

            vim.keymap.set(
                { "n", "v" },
                "<leader>s",
                buffer_search_current_word_or_selection,
                { desc = "Current Buffer Find" }
            )

            vim.keymap.set(
                { "n" },
                "<leader>`",
                require("telescope.builtin").quickfixhistory,
                { desc = "quickfix history" }
            )

            -- lsp integration
            vim.keymap.set(
                "n",
                "<leader>lr",
                "<cmd>Telescope lsp_references theme=ivy<CR>",
                { noremap = true, silent = true, desc = "LSP References" }
            )
            vim.keymap.set(
                "n",
                "<leader>ld",
                "<cmd>Telescope lsp_definitions theme=ivy<CR>",
                { noremap = true, silent = true, desc = "LSP Definitions" }
            )
            vim.keymap.set(
                "n",
                "<leader>li",
                "<cmd>Telescope lsp_implementations theme=ivy<CR>",
                { noremap = true, silent = true, desc = "LSP Implementations" }
            )
            vim.keymap.set(
                "n",
                "<leader>ls",
                "<cmd>Telescope lsp_document_symbols theme=ivy<CR>",
                { noremap = true, silent = true, desc = "LSP Document Symbols" }
            )
            vim.keymap.set(
                "n",
                "<leader>la",
                ":lua vim.lsp.buf.code_action()<CR>",
                { noremap = true, silent = true, desc = "LSP Code Action" }
            )

            --- key map END
        end,
    },
    {
        "nvim-telescope/telescope-live-grep-args.nvim",
        config = function()
            local lga_actions = require("telescope-live-grep-args.actions")
            local prompt_parser = require("telescope-live-grep-args.prompt_parser")

            if not prompt_parser._safe_parse_installed then
                local original_parse = prompt_parser.parse

                prompt_parser.parse = function(prompt, autoquote)
                    local ok, result = pcall(original_parse, prompt, autoquote)
                    if ok then
                        return result
                    end

                    return { "-e", prompt or "" }
                end

                prompt_parser._safe_parse_installed = true
            end

            require("telescope").setup({
                extensions = {
                    live_grep_args = {
                        mappings = {
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            },
                        },
                    },
                },
            })
            require("telescope").load_extension("live_grep_args")
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        opts = {
            extensions = {
                file_browser = {
                    layout_config = {
                        prompt_position = "top",
                    },
                    sorting_strategy = "ascending",
                    hidden = { file_browser = true, folder_browser = true },
                    no_ignore = true,
                    follow_symlinks = true,
                    grouped = true,
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("file_browser")
            vim.keymap.set(
                "n",
                "<leader>fp",
                ":Telescope file_browser path=%:p:h theme=ivy<cr>",
                { desc = "File Browser" }
            )
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        opts = {
            extensions = {
                fzf = {
                    fuzzy = false,
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
        end,
    },

    {
        "jonarrien/telescope-cmdline.nvim",
        keys = {
            { "<leader>x", "<cmd>Telescope cmdline<CR>", desc = "Cmdline" },
        },
    },

    {
        "nvim-telescope/telescope-project.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("project")
            vim.api.nvim_set_keymap(
                "n",
                "<leader><C-p>",
                ":lua require'telescope'.extensions.project.project(require('telescope.themes').get_ivy({}))<CR>",
                { noremap = true, silent = true }
            )
        end,
    },
}

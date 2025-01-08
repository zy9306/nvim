return {
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        config = function()
            local dap = require("dap")
            local dap_widgets = require("dap.ui.widgets")

            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "toggle [d]ebug [b]reakpoint" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "[d]ebug [B]reakpoint" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[d]ebug [c]ontinue (start here)" })
            vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "[d]ebug [C]ursor" })
            vim.keymap.set("n", "<leader>dg", dap.goto_, { desc = "[d]ebug [g]o to line" })
            vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "[d]ebug step [o]ver" })
            vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "[d]ebug step [O]ut" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "[d]ebug [i]nto" })
            vim.keymap.set("n", "<leader>dj", dap.down, { desc = "[d]ebug [j]ump down" })
            vim.keymap.set("n", "<leader>dk", dap.up, { desc = "[d]ebug [k]ump up" })
            vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "[d]ebug [l]ast" })
            vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "[d]ebug [p]ause" })
            vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "[d]ebug [r]epl" })
            vim.keymap.set("n", "<leader>dR", dap.clear_breakpoints, { desc = "[d]ebug [R]emove breakpoints" })
            vim.keymap.set("n", "<leader>ds", dap.session, { desc = "[d]ebug [s]ession" })
            vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "[d]ebug [t]erminate" })
            vim.keymap.set("n", "<leader>dw", dap_widgets.hover, { desc = "[d]ebug [w]idgets" })
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap",
        },
        opts = {},
        config = function(_, opts)
            -- setup dap config by VsCode launch.json file
            -- require("dap.ext.vscode").load_launchjs()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup(opts)
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end
        end,
        keys = {
            {
                "<leader>du",
                function()
                    require("dapui").toggle({})
                end,
                desc = "[d]ap [u]i",
            },
            {
                "<leader>de",
                function()
                    require("dapui").eval()
                end,
                desc = "[d]ap [e]val",
            },
        },
    },
    {
        "leoluz/nvim-dap-go",
        config = function()
            require("dap-go").setup({
                -- config `substitute-path` in `~/.dlv/config.yml`
                dap_configurations = {
                    {
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                        host = "127.0.0.1",
                        port = 40000,
                    },
                },
                delve = {
                    initialize_timeout_sec = 60,
                },
            })
        end,
    },
}

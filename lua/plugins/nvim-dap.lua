return {
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        config = function()
            local dap = require("dap")
            local dap_widgets = require("dap.ui.widgets")

            -- create user command start
            vim.api.nvim_create_user_command("Daptogglebreakpoint", function()
                dap.toggle_breakpoint()
            end, { desc = "Toggle debug breakpoint" })

            vim.api.nvim_create_user_command("Dapsetbreakpoint", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Set debug breakpoint with condition" })

            vim.api.nvim_create_user_command("Dapcontinue", function()
                dap.continue()
            end, { desc = "Continue debugging" })

            vim.api.nvim_create_user_command("Dapruntocursor", function()
                dap.run_to_cursor()
            end, { desc = "Run to cursor" })

            vim.api.nvim_create_user_command("Dapgoto", function()
                dap.goto_()
            end, { desc = "Go to line" })

            vim.api.nvim_create_user_command("Dapstepover", function()
                dap.step_over()
            end, { desc = "Step over" })

            vim.api.nvim_create_user_command("Dapstepout", function()
                dap.step_out()
            end, { desc = "Step out" })

            vim.api.nvim_create_user_command("Dapstepinto", function()
                dap.step_into()
            end, { desc = "Step into" })

            vim.api.nvim_create_user_command("Dapdown", function()
                dap.down()
            end, { desc = "Jump down" })

            vim.api.nvim_create_user_command("Dapup", function()
                dap.up()
            end, { desc = "Jump up" })

            vim.api.nvim_create_user_command("Daprunlast", function()
                dap.run_last()
            end, { desc = "Run last" })

            vim.api.nvim_create_user_command("Dappause", function()
                dap.pause()
            end, { desc = "Pause debugging" })

            vim.api.nvim_create_user_command("Daprepltoggle", function()
                dap.repl.toggle()
            end, { desc = "Toggle REPL" })

            vim.api.nvim_create_user_command("Dapclearbreakpoints", function()
                dap.clear_breakpoints()
            end, { desc = "Clear all breakpoints" })

            vim.api.nvim_create_user_command("Dapsession", function()
                dap.session()
            end, { desc = "Show session" })

            vim.api.nvim_create_user_command("Dapterminate", function()
                dap.terminate()
            end, { desc = "Terminate debugging" })

            vim.api.nvim_create_user_command("Dapwidgetshover", function()
                dap_widgets.hover()
            end, { desc = "Show widgets" })
            -- create user command end
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

            -- create user command start
            vim.api.nvim_create_user_command("Dapuitoggle", function()
                require("dapui").toggle({})
            end, { desc = "Toggle dap ui" })
            vim.api.nvim_create_user_command("Dapuieval", function()
                require("dapui").eval()
            end, { desc = "Dap ui eval" })
            -- create user command end
        end,
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

return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "antoinemadec/FixCursorHold.nvim",

            { "fredrikaverpil/neotest-golang", version = "*" },
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-golang"),
                },
            })
            -- create commands start
            vim.api.nvim_create_user_command("Neotestattach", function()
                require("neotest").run.attach()
            end, {})

            vim.api.nvim_create_user_command("Neotestrunfile", function()
                require("neotest").run.run(vim.fn.expand("%"))
            end, {})

            vim.api.nvim_create_user_command("Neotestrunall", function()
                require("neotest").run.run(vim.uv.cwd())
            end, {})

            vim.api.nvim_create_user_command("Neotestsuite", function()
                require("neotest").run.run({ suite = true })
            end, {})

            vim.api.nvim_create_user_command("Neotestnearest", function()
                require("neotest").run.run()
            end, {})

            vim.api.nvim_create_user_command("Neotestlast", function()
                require("neotest").run.run_last()
            end, {})

            vim.api.nvim_create_user_command("Neotestsummary", function()
                require("neotest").summary.toggle()
            end, {})

            vim.api.nvim_create_user_command("Neotestoutput", function()
                require("neotest").output.open({ enter = true, auto_close = true })
            end, {})

            vim.api.nvim_create_user_command("Neotestoutputpanel", function()
                require("neotest").output_panel.toggle()
            end, {})

            vim.api.nvim_create_user_command("Neotestterminate", function()
                require("neotest").run.stop()
            end, {})

            vim.api.nvim_create_user_command("Neotestdebug", function()
                require("neotest").run.run({ suite = false, strategy = "dap" })
            end, {})
            -- create commands end
        end,

        -- keys = {
        --     {
        --         "<leader>ta",
        --         function()
        --             require("neotest").run.attach()
        --         end,
        --         desc = "[t]est [a]ttach",
        --     },
        --     {
        --         "<leader>tf",
        --         function()
        --             require("neotest").run.run(vim.fn.expand("%"))
        --         end,
        --         desc = "[t]est run [f]ile",
        --     },
        --     {
        --         "<leader>tA",
        --         function()
        --             require("neotest").run.run(vim.uv.cwd())
        --         end,
        --         desc = "[t]est [A]ll files",
        --     },
        --     {
        --         "<leader>tS",
        --         function()
        --             require("neotest").run.run({ suite = true })
        --         end,
        --         desc = "[t]est [S]uite",
        --     },
        --     {
        --         "<leader>tn",
        --         function()
        --             require("neotest").run.run()
        --         end,
        --         desc = "[t]est [n]earest",
        --     },
        --     {
        --         "<leader>tl",
        --         function()
        --             require("neotest").run.run_last()
        --         end,
        --         desc = "[t]est [l]ast",
        --     },
        --     {
        --         "<leader>ts",
        --         function()
        --             require("neotest").summary.toggle()
        --         end,
        --         desc = "[t]est [s]ummary",
        --     },
        --     {
        --         "<leader>to",
        --         function()
        --             require("neotest").output.open({ enter = true, auto_close = true })
        --         end,
        --         desc = "[t]est [o]utput",
        --     },
        --     {
        --         "<leader>tO",
        --         function()
        --             require("neotest").output_panel.toggle()
        --         end,
        --         desc = "[t]est [O]utput panel",
        --     },
        --     {
        --         "<leader>tt",
        --         function()
        --             require("neotest").run.stop()
        --         end,
        --         desc = "[t]est [t]erminate",
        --     },
        --     {
        --         "<leader>td",
        --         function()
        --             require("neotest").run.run({ suite = false, strategy = "dap" })
        --         end,
        --         desc = "Debug nearest test",
        --     },
        -- },
    },
}

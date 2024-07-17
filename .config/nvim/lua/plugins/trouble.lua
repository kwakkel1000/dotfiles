return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                signs = {
                    -- icons / text used for a diagnostic
                    error = "",
                    warning = "",
                    hint = "",
                    information = "",
                    other = "",
                },
                use_diagnostic_signs = true
                --                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle()
            end)

            vim.keymap.set("n", "[t", function()
                require("trouble").next({ skip_groups = true, jump = true });
            end)

            vim.keymap.set("n", "]t", function()
                require("trouble").previous({ skip_groups = true, jump = true });
            end)

            --vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
            --    { silent = true, noremap = true, desc = 'trouble quickfix' }
            --)
            vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end, { desc = 'trouble' })
            vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end,
                { desc = 'trouble workspace diagnostics' })
            vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end,
                { desc = 'trouble document diagnostics' })
            vim.keymap.set("n", "<leader>xl", function() require("trouble").open("quickfix") end,
                { desc = 'trouble quickfix' })
            vim.keymap.set("n", "<leader>xq", function() require("trouble").open("loclist") end,
                { desc = 'trouble loclist' })
            vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end,
                { desc = 'trouble lsp references' })
        end
    },
}

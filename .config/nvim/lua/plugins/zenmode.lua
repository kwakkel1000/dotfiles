return {
    {
        "folke/twilight.nvim",
    },
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {
                plugins = {
                    gitsigns = {
                        enabled = true,
                    },
                    wezterm = {
                        enabled = false,
                    }
                },
            }

            vim.keymap.set("n", "<leader>zz", function()
                local width = .85
                if vim.api.nvim_win_get_width(0) > 200 then
                    width = 180
                end
                require("zen-mode").setup {
                    window = {
                        width = 180,
                        options = {}
                    },
                }
                require("gitsigns").toggle_current_line_blame()
                require("zen-mode").toggle({
                    window = {
                        width = width,
                    }
                })
                vim.wo.wrap = false
                vim.wo.number = true
                vim.wo.rnu = false
                -- vim.wo.rnu = true
            end, { desc = "zen mode 180" })


            vim.keymap.set("n", "<leader>zZ", function()
                local width = .75
                if vim.api.nvim_win_get_width(0) > 200 then
                    width = 80
                end
                require("zen-mode").setup {
                    window = {
                        width = 80,
                        options = {}
                    },
                }
                require("gitsigns").toggle_current_line_blame()
                require("zen-mode").toggle({
                    window = {
                        width = width,
                    }
                })
                vim.wo.wrap = false
                -- vim.wo.number = true
                vim.wo.number = false
                vim.wo.rnu = false
                vim.opt.colorcolumn = "0"
            end, { desc = "zen mode 80" })
        end
    },
}

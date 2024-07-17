return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local wk = require("which-key")
        wk.setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
        wk.add({
            { "<leader>g",  group = "git" },
            { "<leader>p",  group = "file" },
            { "<leader>t",  group = "terminal" },
            { "<leader>x",  group = "trouble" },
            { "<leader>z",  group = "zen mode" },
            { "<leader>S",  group = "Source Open file" },
            { "<leader>SO", group = "Source Open file" },
        })
    end
}

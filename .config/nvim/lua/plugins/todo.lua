return {
    {
        "folke/todo-comments.nvim",
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("todo-comments").setup({
                search = {
                    -- regex that will be used to match keywords.
                    -- don't replace the (KEYWORDS) placeholder
                    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
                },
            })
            vim.keymap.set("n", "<leader>pt", vim.cmd.TodoTelescope, { desc = 'todo telescope' })
        end
    },
}

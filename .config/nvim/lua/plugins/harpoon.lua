return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = 'add to harpoon' })
        vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = 'open harpoon quick menu' })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = 'open harpoon quick menu' })

        for i = 1, 5 do
            vim.keymap.set("n",
                string.format("<leader>%s", i),
                function()
                    harpoon:list():select(i)
                end, { desc = string.format("open harpoon %s", i) }
            )
        end
    end
}

local symbols = require("symbols-outline")
symbols.setup({
    auto_close = true,
})

vim.keymap.set("n", "<leader>o", symbols.toggle_outline, { desc = "symbols outline" })

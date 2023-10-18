local obsidian = require("obsidian")

obsidian.setup({
    dir = "~/obsidian/fortanix",
    daily_notes = {
        template = "Daily tasks.md"
    },
    mappings = {
        -- ["gf"] = ...
    },
    -- see below for full list of options 👇
})

vim.keymap.set("n", "gf", function()
    if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<CR>"
    else
        return "gf"
    end
end, { noremap = false, expr = true })


vim.keymap.set('n', '<leader>pb', "<cmd>ObsidianQuickSwitch<CR>", { desc = 'obisidian quick switch' })

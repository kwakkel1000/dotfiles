local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = 'add to harpoon' })
vim.keymap.set("n", "<leader>hl", ui.toggle_quick_menu, { desc = 'open harpoon quick menu' })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = 'open harpoon quick menu' })


--vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = 'open harpoon 1' })
--vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end, { desc = 'open harpoon 2' })
--vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { desc = 'open harpoon 3' })
--vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { desc = 'open harpoon 4' })

for i = 1, 5 do
    vim.keymap.set("n",
        string.format("<leader>%s", i),
        function()
            ui.nav_file(i)
        end, { desc = string.format("open harpoon %s", i) }
    )
end
for i = 1, 5 do
    vim.keymap.set("n",
        string.format("<leader>t%s", i),
        function()
            term.gotoTerminal(i)
        end, { desc = string.format("open harpoon terminal %s", i) }
    )
end

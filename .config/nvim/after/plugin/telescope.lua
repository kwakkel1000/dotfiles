local builtin = require('telescope.builtin')
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup {
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
    },
}

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'git files' })
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = 'grep search file' })
vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = 'help telescope' })
vim.keymap.set('n', '<leader>po', builtin.oldfiles, { desc = 'previously open files' })

vim.keymap.set('n', '<leader>pn', telescope.extensions.notify.notify, { desc = 'previously notifications' })

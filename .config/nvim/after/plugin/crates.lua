local crates = require('crates')
--local opts = { silent = true }

vim.keymap.set('n', '<leader>ct', crates.toggle, { desc = "crates toggle" })
vim.keymap.set('n', '<leader>cr', crates.reload, { desc = "crates reload" })

vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, { desc = "crates show versions" })
vim.keymap.set('n', '<leader>cf', crates.show_features_popup, { desc = "crates show features" })
vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, { desc = "crates show dependencies" })

vim.keymap.set('n', '<leader>cu', crates.update_crate, { desc = "crates update crate" })
vim.keymap.set('v', '<leader>cu', crates.update_crates, { desc = "crates update crates" })
vim.keymap.set('n', '<leader>ca', crates.update_all_crates, { desc = "crates update all crates" })
vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, { desc = "crates upgrade crate" })
vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, { desc = "crates upgrade crates" })
vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates, { desc = "crates upgrade all crates" })

--vim.keymap.set('n', '<leader>ce', crates.expand_plain_crate_to_inline_table, opts)
--vim.keymap.set('n', '<leader>cE', crates.extract_crate_into_table, opts)

vim.keymap.set('n', '<leader>cH', crates.open_homepage, { desc = "crates open homepage" })
vim.keymap.set('n', '<leader>cR', crates.open_repository, { desc = "crates open repo" })
vim.keymap.set('n', '<leader>cD', crates.open_documentation, { desc = "crates open documentation" })
vim.keymap.set('n', '<leader>cC', crates.open_crates_io, { desc = "crates open crates.io" })

crates.setup {
    popup = {
        autofocus = true,
    }
}

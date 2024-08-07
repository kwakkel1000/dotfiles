return {
    {
        'codota/tabnine-nvim',
        build = "./dl_binaries.sh",
        config = function()
            require('tabnine').setup({
                disable_auto_comment = true,
                accept_keymap = "<Tab>",
                dismiss_keymap = "<C-]>",
                debounce_ms = 800,
                suggestion_color = { gui = "#808080", cterm = 244 },
                exclude_filetypes = { "TelescopePrompt", "NvimTree" },
                log_file_path = nil, -- absolute path to Tabnine log file
            })
        end
    },
    {
        'tzachar/cmp-tabnine',
        build = './install.sh',
        dependencies = 'hrsh7th/nvim-cmp',
        config = function()
            if vim.fn.has('win32') == 0 then
                --require('tabnine').setup({
                --    disable_auto_comment = true,
                --    accept_keymap = "<Tab>",
                --    dismiss_keymap = "<C-]>",
                --    debounce_ms = 800,
                --    suggestion_color = { gui = "#808080", cterm = 244 },
                --    exclude_filetypes = { "TelescopePrompt" },
                --    log_file_path = nil, -- absolute path to Tabnine log file
                --    run_on_every_keystroke = true,
                --    snippet_placeholder = "..",
                --})
                local tabnine = require('cmp_tabnine.config')

                tabnine:setup({
                    --    disable_auto_comment = true,
                    accept_keymap = "<Tab>",
                    dismiss_keymap = "<C-]>",
                    debounce_ms = 800,
                    suggestion_color = { gui = "#808080", cterm = 244 },
                    exclude_filetypes = { "TelescopePrompt" },
                    log_file_path = nil, -- absolute path to Tabnine log file
                    run_on_every_keystroke = true,
                    snippet_placeholder = "..",
                })
            end
        end
    },
}

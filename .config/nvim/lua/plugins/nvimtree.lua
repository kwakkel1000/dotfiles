return {


    -- icons
    { "echasnovski/mini.nvim",      version = false },
    { "nvim-tree/nvim-web-devicons" },
    -- file explorer
    {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
        config = function()
            local nvim_tree = require("nvim-tree")
            nvim_tree.setup({

                disable_netrw = true,
                sort_by = "case_sensitive",
                view = {
                    adaptive_size = true,
                    centralize_selection = true,
                    --number = true,
                    --relativenumber = true,
                },
                filters = {
                    git_ignored = false,
                    --dotfiles = true,
                },
                renderer = {
                    group_empty = true,
                    highlight_git = true,
                    highlight_opened_files = "all",
                },
                update_focused_file = {
                    enable = true,
                },

                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                    icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                    },
                },
                log = {
                    types = {
                        diagnostics = true,
                    }
                },
                actions = {
                    open_file = {
                        quit_on_open = true,
                    },
                    change_dir = {
                        enable = false,
                    },
                },
            })

            ---- auto close
            --local function is_modified_buffer_open(buffers)
            --    for _, v in pairs(buffers) do
            --        if v.name:match("NvimTree_") == nil then
            --            return true
            --        end
            --    end
            --    return false
            --end
            --
            --vim.api.nvim_create_autocmd("BufEnter", {
            --    nested = true,
            --    callback = function()
            --        if
            --            #vim.api.nvim_list_wins() == 1
            --            and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil
            --            and is_modified_buffer_open(vim.fn.getbufinfo({ bufmodified = 1 })) == false
            --        then
            --            vim.cmd("quit")
            --        end
            --    end,
            --})

            require("lsp-file-operations").setup()
            vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeToggle, { desc = 'Open explorer' })
        end
    },
    {
        "antosha417/nvim-lsp-file-operations",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        }
    },
}

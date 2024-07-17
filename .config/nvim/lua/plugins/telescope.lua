return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        local builtin = require('telescope.builtin')
        local trouble = require("trouble.sources.telescope")
        local telescope = require("telescope")

        telescope.setup {
            extensions = {
                advanced_git_search = {
                }
            },
            defaults = {
                mappings = {
                    i = { ["<c-t>"] = trouble.open },
                    n = { ["<c-t>"] = trouble.open },
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
        vim.keymap.set('n', '<leader>pc', builtin.commands, { desc = 'available commands' })
        vim.keymap.set('n', '<leader>pd', builtin.diagnostics, { desc = 'search diagnostics' })

        vim.keymap.set('n', '<leader>pn', telescope.extensions.notify.notify, { desc = 'previously notifications' })
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = 'search cword' })
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = 'search cWORD' })

        local telescope_pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local previewers = require("telescope.previewers")
        local putils = require("telescope.previewers.utils")
        local from_entry = require("telescope.from_entry")
        local conf = require("telescope.config").values

        local branch_diff = function(opts)
            return previewers.new_buffer_previewer({
                title = "Git Branch Diff Preview",
                get_buffer_by_name = function(_, entry)
                    return entry.value
                end,

                define_preview = function(self, entry, _)
                    local file_name = entry.value
                    local get_git_status_command = "git status -s -- " .. file_name
                    local git_status = io.popen(get_git_status_command):read("*a")
                    local git_status_short = string.sub(git_status, 1, 1)
                    if git_status_short ~= "" then
                        local p = from_entry.path(entry, true)
                        if p == nil or p == "" then
                            return
                        end
                        conf.buffer_previewer_maker(p, self.state.bufnr, {
                            bufname = self.state.bufname,
                            winid = self.state.winid,
                        })
                    else
                        putils.job_maker(
                            { "git", "--no-pager", "diff", opts.base_branch .. "..HEAD", "--", file_name },
                            self.state.bufnr,
                            {
                                value = file_name,
                                bufname = self.state.bufname,
                            }
                        )
                        putils.regex_highlighter(self.state.bufnr, "diff")
                    end
                end,
            })
        end

        vim.api.nvim_create_user_command("TelescopeDiffMaster", function()
            local command = "git diff --name-only --relative $(git merge-base master HEAD)"

            local previewer = branch_diff({ base_branch = "master" })
            local entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry,
                    ordinal = entry,
                }
            end

            local handle = io.popen(command)

            if handle == nil then
                print("could not run specified command:" .. command)
                return
            end

            local result = handle:read("*a")

            handle:close()

            local files = {}

            for token in string.gmatch(result, "[^%c]+") do
                table.insert(files, token)
            end
            local opts = {
                prompt_title = "changes from master_files",
                finder = finders.new_table({
                    results = files,
                    entry_maker = entry_maker,
                }),
                previewer = previewer,
            }

            telescope_pickers.new(opts):find()
        end, {})

        vim.keymap.set('n', '<leader>gd', "<Esc>:TelescopeDiffMaster<CR>", { desc = 'git diff with master' })
    end
}

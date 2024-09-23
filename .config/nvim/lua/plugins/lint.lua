return {
    {
        "mfussenegger/nvim-lint",
        config = function()
            require('lint').linters_by_ft = {
                ['yaml.ansible'] = { 'ansible_lint', },
                bzl = { 'buildifier', },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end
    },
    {
        "ckipp01/nvim-jenkinsfile-linter",
        ft = { 'groovy' },
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            vim.keymap.set('n', '<leader>jl', function() require("jenkinsfile_linter").validate() end,
                { desc = "validate jenkins" })
        end
    }
}

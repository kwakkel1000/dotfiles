require('lint').linters_by_ft = {
    ['yaml.ansible'] = { 'ansible_lint', },
    bzl = { 'buildifier', },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

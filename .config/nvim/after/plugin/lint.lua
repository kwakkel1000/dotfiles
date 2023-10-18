require('lint').linters_by_ft = {
    bzl = { 'buildifier', },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

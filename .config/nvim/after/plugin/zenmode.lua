require("zen-mode").setup {
    plugins = {
        gitsigns = {
            enabled = true,
        },
        wezterm = {
            enabled = true,
        }
    },
}

vim.keymap.set("n", "<leader>zz", function()
    local width = .85
    if vim.api.nvim_win_get_width(0) > 200 then
        width = 180
    end
    require("gitsigns").toggle_current_line_blame()
    --package.loaded.gitsigns.toggle_current_line_blame()
    require("zen-mode").toggle({
        window = {
            width = width,
        },
    })
    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.rnu = true
    --ColorMyPencils()
end, { desc = "zen mode 180" })


vim.keymap.set("n", "<leader>zZ", function()
    local width = .75
    if vim.api.nvim_win_get_width(0) > 200 then
        width = 80
    end
    require("gitsigns").toggle_current_line_blame()
    --package.loaded.gitsigns.toggle_current_line_blame()
    require("zen-mode").toggle({
        window = {
            width = width,
        },
    })
    vim.wo.wrap = false
    vim.wo.number = false
    vim.wo.rnu = false
    vim.opt.colorcolumn = "0"
    --ColorMyPencils()
end, { desc = "zen mode 80" })

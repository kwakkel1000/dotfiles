return {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    config = function()
        require("neoconf").setup({
            import = {
                vscode = false, -- local .vscode/settings.json
                coc = true,     -- global/local coc-settings.json
                nlsp = true,    -- global/local nlsp-settings.nvim json settings
            },                  -- override any of the default settings here
        })
    end
}

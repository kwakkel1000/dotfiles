return {
    "lewis6991/gitsigns.nvim",
    requires = { "petertriho/nvim-scrollbar", opt = false },
    config = function()
        require("scrollbar.handlers.gitsigns").setup()
    end
}

return {
    "rcarriga/nvim-notify",
    config = function()
        vim.notify = require('notify')
        require("notify").setup {
            --stages = 'fade_in_slide_out',
            stages = 'slide',
            background_colour = 'FloatShadow',
            timeout = 3000,
        }
    end
}

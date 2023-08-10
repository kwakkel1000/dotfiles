require("notify").setup {
    --stages = 'fade_in_slide_out',
    stages = 'slide',
    background_colour = 'FloatShadow',
    timeout = 3000,
}
vim.notify = require('notify')

require('lsp-notify').setup({})

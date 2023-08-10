require('rose-pine').setup({
    disable_background = true,
    variant = 'main',
    groups = {
        punctuation = 'highlight_med',
    }
})

require("catppuccin").setup({
    flavour = "latte", -- latte, frappe, macchiato, mocha
    background = {     -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
    term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false,            -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15,          -- percentage of the shade to apply to the inactive window
    },
    no_italic = false,              -- Force no italic
    no_bold = false,                -- Force no bold
    no_underline = false,           -- Force no underline
    styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" },    -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})


function ColorMyPencils(color)
    if color == "light" then
        color = "catppuccin"
    end
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    --    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

local popup = require("plenary.popup")

local Win_id

function ShowColorsMenu(opts, cb)
    local height = 10
    local width = 30
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

    Win_id = popup.create(opts, {
        title = "Colors",
        highlight = "ColorsWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
        callback = cb,
    })
    local bufnr = vim.api.nvim_win_get_buf(Win_id)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseColorsMenu()<CR>", { silent = false })
end

function CloseColorsMenu()
    vim.api.nvim_win_close(Win_id, true)
end

function MyColorsMenu()
    local opts = {
        "light",
        "dark"
    }
    local cb = function(_, sel)
        if sel == "light" then
            ColorMyPencils("light")
        elseif sel == "dark" then
            ColorMyPencils()
        end
        --        print("it works")
    end
    ShowColorsMenu(opts, cb)
end

vim.keymap.set("n", "<leader>co", '<cmd>lua MyColorsMenu()<CR>', { desc = "show colors menu" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    -- Colors
    { "catppuccin/nvim",  name = "catppuccin", priority = 1000 },
    { "rose-pine/neovim", name = "rose-pine" },
    -- colorize in code
    "norcalli/nvim-colorizer.lua",

    -- Config
    { "folke/neoconf.nvim",              cmd = "Neoconf" },

    -- appearance
    "folke/zen-mode.nvim",
    "folke/twilight.nvim",
    -- file explorere
    {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    },
    {
        'antosha417/nvim-lsp-file-operations',
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        }
    },

    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                signs = {
                    -- icons / text used for a diagnostic
                    error = "",
                    warning = "",
                    hint = "",
                    information = "",
                    other = "",
                },
                use_diagnostic_signs = true
                --                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },

    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },

    -- todo
    {
        "folke/todo-comments.nvim",
        requires = { 'nvim-lua/plenary.nvim' },
    },

    -- status bar
    {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = false }
    },

    -- scrollbar
    "petertriho/nvim-scrollbar",
    -- Git blame + add/del/modified in scrollbar
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            --require('gitsigns').setup()
            require("scrollbar.handlers.gitsigns").setup()
        end
    },

    "folke/which-key.nvim",



    -- Git
    "tpope/vim-fugitive",
    {
        "aaronhallaert/advanced-git-search.nvim",
        config = function()
            require("telescope").load_extension("advanced_git_search")
        end,
        requires = {
            -- Insert Dependencies here
        },
    },

    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            -- require('hlslens').setup() is not required
            require("scrollbar.handlers.search").setup({
                -- hlslens config overrides
            })
        end,
    },

    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
    "nvim-treesitter/playground",
    -- Quick file shifter
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    },
    -- refactor code
    "theprimeagen/refactoring.nvim",
    -- undo tree <3
    "mbbill/undotree",
    "nvim-treesitter/nvim-treesitter-context",

    -- Autocompletion
    { "hrsh7th/nvim-cmp", commit = "c4e491a87eeacf0408902c32f031d802c7eafce8" },
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",

    -- color brackets
    "hiphish/rainbow-delimiters.nvim",

    -- rust crates
    {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    },

    -- LSP
    "simrat39/rust-tools.nvim",
    "folke/neodev.nvim",
    --{ 'codota/tabnine-nvim', build = "./dl_binaries.sh" },
    {
        'tzachar/cmp-tabnine',
        build = './install.sh',
        dependencies = 'hrsh7th/nvim-cmp',
    },

    -- LSP Support
    'rcarriga/nvim-notify',


    'neovim/nvim-lspconfig',
    'nvim-lua/lsp-status.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- nvim lint
    'mfussenegger/nvim-lint',
    -- formatter
    "mhartington/formatter.nvim",
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = function()
            require("fidget").setup {
                -- options
            }
        end,
    },
    -- ansible detector
    'mfussenegger/nvim-ansible',

    -- fancy pictograms
    'onsails/lspkind.nvim',
    -- use { 'tzachar/cmp-tabnine' }

    -- Snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',

    -- Debugging
    'mfussenegger/nvim-dap',
    "nvim-lua/plenary.nvim",

    --  use("github/copilot.vim")
    --    use { 'codota/tabnine-nvim', run = "./dl_binaries.sh" }
    "laytan/cloak.nvim",

    --use('gsuuon/llm.nvim')

    -- symbols outline
    'simrat39/symbols-outline.nvim',


    'nvim-treesitter/nvim-treesitter-refactor',

    -- obsidian
    {
        "epwalsh/obsidian.nvim",
        requires = {
            -- Required.
            "nvim-lua/plenary.nvim",
        },
    },
})

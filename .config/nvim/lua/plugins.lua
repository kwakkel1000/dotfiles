local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end


local packer_bootstrap = ensure_packer()
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Colors
    use { "catppuccin/nvim", as = "catppuccin" }
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })
    -- colorize in code
    use("norcalli/nvim-colorizer.lua")

    -- Config
    use("folke/neoconf.nvim")

    -- appearance
    use("folke/zen-mode.nvim")
    use("folke/twilight.nvim")
    -- file explorere
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }
    use {
        'antosha417/nvim-lsp-file-operations',
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        }
    }

    use({
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
    })

    use {
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
    }

    -- todo
    use { "folke/todo-comments.nvim",
        requires = { 'nvim-lua/plenary.nvim' },
    }

    -- status bar
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = false }
    }

    -- scrollbar
    use("petertriho/nvim-scrollbar")
    -- Git blame + add/del/modified in scrollbar
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            --require('gitsigns').setup()
            require("scrollbar.handlers.gitsigns").setup()
        end
    }
    use {
        "kevinhwang91/nvim-hlslens",
        config = function()
            -- require('hlslens').setup() is not required
            require("scrollbar.handlers.search").setup({
                -- hlslens config overrides
            })
        end,
    }

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/playground")
    -- Quick file shifter
    use("theprimeagen/harpoon")
    -- refactor code
    use("theprimeagen/refactoring.nvim")
    -- undo tree <3
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("nvim-treesitter/nvim-treesitter-context");

    -- Autocompletion
    use { 'hrsh7th/nvim-cmp', commit = 'c4e491a87eeacf0408902c32f031d802c7eafce8' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
    use { 'hrsh7th/cmp-nvim-lua' }

    -- color brackets
    use("hiphish/rainbow-delimiters.nvim");

    -- rust crates
    use {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    }

    -- LSP
    use { "simrat39/rust-tools.nvim" }
    local tabnine_install = './install.sh'
    if vim.fn.has('win32') then
        tabnine_install = 'powershell ./install.ps1'
    end
    use { 'tzachar/cmp-tabnine', run = tabnine_install, requires = 'hrsh7th/nvim-cmp' }
    --  use {
    --      "jcdickinson/http.nvim",
    --      run = "cargo build --workspace --release"
    --  }
    if vim.fn.has('win32') == 0 then
        -- cmp codium
        use {
            "jcdickinson/codeium.nvim",
            requires = {
                --          "jcdickinson/http.nvim",
                "nvim-lua/plenary.nvim",
                "hrsh7th/nvim-cmp",
            },
            config = function()
                require("codeium").setup({
                })
            end
        }
    end
    -- official codium
    -- use { 'Exafunction/codeium.vim' }

    -- LSP Support
    use { 'rcarriga/nvim-notify' }


    use { 'neovim/nvim-lspconfig' }
    use { 'nvim-lua/lsp-status.nvim' }
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }
    -- nvim lint
    use { 'mfussenegger/nvim-lint' }
    -- formatter
    use { 'mhartington/formatter.nvim' }
    use {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = function()
            require("fidget").setup {
                -- options
            }
        end,
    }

    -- fancy pictograms
    use { 'onsails/lspkind.nvim' }
    -- use { 'tzachar/cmp-tabnine' }

    -- Snippets
    use { 'L3MON4D3/LuaSnip' }
    use { 'rafamadriz/friendly-snippets' }

    -- Debugging
    use { 'mfussenegger/nvim-dap' }
    use { 'nvim-lua/plenary.nvim' }

    --    use {
    --        'VonHeikemen/lsp-zero.nvim',
    --        branch = 'v2.x',
    --        requires = {
    --            -- LSP Support
    --            { 'neovim/nvim-lspconfig' },
    --            { 'nvim-lua/lsp-status.nvim' },
    --            { 'williamboman/mason.nvim' },
    --            { 'williamboman/mason-lspconfig.nvim' },
    --
    --            -- Autocompletion
    --            { 'hrsh7th/nvim-cmp' },
    --            { 'hrsh7th/cmp-buffer' },
    --            { 'hrsh7th/cmp-path' },
    --            { 'saadparwaiz1/cmp_luasnip' },
    --            { 'hrsh7th/cmp-nvim-lsp' },
    --            { 'hrsh7th/cmp-nvim-lua' },
    --            { 'tzachar/cmp-tabnine' },
    --
    --            -- Snippets
    --            { 'L3MON4D3/LuaSnip' },
    --            { 'rafamadriz/friendly-snippets' },
    --
    --            -- Debugging
    --            { 'mfussenegger/nvim-dap' },
    --            { 'nvim-lua/plenary.nvim' },
    --
    --        }
    --    }

    --  use("github/copilot.vim")
    --    use { 'codota/tabnine-nvim', run = "./dl_binaries.sh" }
    use("eandrju/cellular-automaton.nvim")
    use("laytan/cloak.nvim")

    use('gsuuon/llm.nvim')

    -- symbols outline
    use { 'simrat39/symbols-outline.nvim' }


    use { 'nvim-treesitter/nvim-treesitter-refactor' }

    -- obsidian
    use({
        "epwalsh/obsidian.nvim",
        requires = {
            -- Required.
            "nvim-lua/plenary.nvim",
        },
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)

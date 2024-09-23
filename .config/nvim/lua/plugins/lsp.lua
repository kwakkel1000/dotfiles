vim.keymap.set('n', '<leader>Hg',
    function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end, { desc = "Hints Inlay global" }
)
vim.keymap.set('n', '<leader>Hb',
    function()
        local buffer = { bufnr = vim.api.nvim_get_current_buf() }
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(buffer), buffer)
    end, { desc = "Hints Inlay buffer" }
)

local lsp_nmap = function(buffer, keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = buffer, remap = false, desc = desc })
end

local on_attach = function(client, buffer)
    local nmap = function(keys, func, desc)
        lsp_nmap(buffer, keys, func, desc)
    end

    -- if client.supports_method("textDocument/completion") then
    --     vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    -- end

    if client ~= nil then
        if client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
        end
        if client.supports_method("textDocument/declaration") then
            nmap("gD", function() vim.lsp.buf.declaration() end, "declaration")
        end
        if client.server_capabilities ~= nil and client.server_capabilities.codeActionProvider then
            nmap("<leader>vca", function() vim.lsp.buf.code_action() end, "code action")
        else
            nmap("<leader>vca", function() end, "code action not available")
        end
    end
    nmap("gd", function() vim.lsp.buf.definition() end, "definition")
    nmap("K", function() vim.lsp.buf.hover() end, "hover")
    nmap("gi", function() vim.lsp.buf.implementation() end, "implementation")
    nmap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end, "workspace symbol")
    nmap("<leader>vd", function() vim.diagnostic.open_float() end, "open float")
    nmap("[d", function() vim.diagnostic.goto_next() end, "diagnostic next")
    nmap("]d", function() vim.diagnostic.goto_prev() end, "diagnostic prev")
    nmap("<leader>vrr", function() vim.lsp.buf.references() end, "references")
    nmap("<leader>vrn", function() vim.lsp.buf.rename() end, "rename")
    nmap("<C-k>", function() vim.lsp.buf.signature_help() end, "signature help")
end

local on_attach_rust = function(buffer)
    local nmap = function(keys, func, desc)
        lsp_nmap(buffer, keys, func, desc)
    end

    nmap("<leader>vem", function() vim.cmd.RustLsp('expandMacro') end, "expand macro")
    nmap("<leader>vrpm", function() vim.cmd.RustLsp('rebuildProcMacros') end, "rebuild proc macros")
    nmap("<leader>vrd", function() vim.cmd.RustLsp('renderDiagnostic') end, "render diagnostic")
    nmap("<leader>ca", function() vim.cmd.RustLsp { 'hover', 'actions' } end, "hover actions")
    nmap("<leader>vca", function() vim.cmd.RustLsp('codeAction') end, "code action")
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        on_attach(client, bufnr)
    end,
})

vim.diagnostic.config({
    severity_sort = true,
    virtual_text = {
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        }
    },
    -- update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})


local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '"' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/neoconf.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lua",
            "rcarriga/nvim-notify",
            "nvim-lua/lsp-status.nvim",
            "L3MON4D3/LuaSnip",
            "j-hui/fidget.nvim",


            "onsails/lspkind.nvim",
        },

        config = function()
            local cmp = require('cmp')
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())

            local lua_check_third_party = true
            if vim.fn.has('win32') then
                lua_check_third_party = false
            end

            require("fidget").setup({})
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    'ansiblels',
                    'awk_ls',
                    'bashls',
                    'ltex',
                    'cssls',
                    'html',
                    'jsonls',
                    'lua_ls',
                    'pylsp',
                    -- 'rust_analyzer',
                    'taplo',
                    -- 'tsserver',
                },
                handlers = {
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    zls = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.zls.setup({
                            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                            settings = {
                                zls = {
                                    enable_inlay_hints = true,
                                    enable_snippets = true,
                                    warn_style = true,
                                },
                            },
                        })
                        vim.g.zig_fmt_parse_errors = 0
                        vim.g.zig_fmt_autosave = 0
                    end,
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = "Lua 5.1"
                                        --version = 'LuaJIT',
                                    },
                                    diagnostics = {
                                        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                    },
                                    workspace = {
                                        -- Make the server aware of Neovim runtime files
                                        library = vim.api.nvim_get_runtime_file("", true),
                                        checkThirdParty = lua_check_third_party,
                                    },
                                    -- Do not send telemetry data containing a randomized but unique identifier
                                    telemetry = {
                                        enable = false,
                                    },
                                }
                            }
                        }
                    end,
                }
            })
        end
    },
    {
        "mrcjkb/rustaceanvim",
        version = '^5', -- Recommended
        -- ft = { 'rust' },
        lazy = false,
        config = function()
            local rust_analyzer = {
                restartServerOnConfigChange = true,
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                check = {
                    -- default to true
                    -- allTargets = false,
                    -- we don't need this
                    -- extraArgs = { "--locked", "-j2" },
                    -- rustaceanvim defaults to clippy
                    -- overrideCommand = { "cargo", "clippy", "--workspace", "--message-format=json", "--", "-W", "clippy::pedantic", "-W", "clippy::nursery", },
                },
                procMacro = {
                    enable = true,
                },
                diagnostics = {
                    enable = true,
                    disabled = { "unresolved-proc-macro" },
                },
                -- lru = {
                --     capacity = 512,
                -- }
                inlayHints = {
                    -- bindingModeHints = {
                    --     enable = true,
                    -- },
                    chainingHints = {
                        enable = true,
                    },
                    closingBraceHints = {
                        enable = true,
                        minLines = 25,
                    },
                    -- closureReturnTypeHints = {
                    --     enable = "never",
                    -- },
                    -- lifetimeElisionHints = {
                    --     enable = "always",
                    --     useParameterNames = false,
                    -- },
                    maxLength = 25,
                    parameterHints = {
                        enable = true,
                    },
                    -- reborrowHints = {
                    --     enable = "always",
                    -- },
                    renderColons = true,
                    typeHints = {
                        enable = true,
                        hideClosureInitialization = false,
                        hideNamedConstructor = false,
                    },
                },
            }

            vim.g.rustaceanvim = {
                -- Plugin configuration
                tools = {
                    hover_actions = {
                        auto_focus = true
                    },
                    test_executor = 'background',
                },
                -- LSP configuration
                server = {
                    on_attach = function(_client, bufnr)
                        -- on_attach(client, bufnr, true)
                        on_attach_rust(bufnr)
                    end,
                    default_settings = {
                        -- rust-analyzer language server configuration
                        ['rust-analyzer'] = rust_analyzer,
                    },
                },
                -- DAP configuration
                dap = {
                },
            }
        end
    },
}

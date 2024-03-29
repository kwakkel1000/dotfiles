--local rust_tools = require('rust-tools')
local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local compare = require('cmp.config.compare')
require("neodev").setup({
    -- add any options here, or leave empty to use the default settings
})
require("neoconf").setup({
    import = {
        vscode = false, -- local .vscode/settings.json
        coc = true,     -- global/local coc-settings.json
        nlsp = true,    -- global/local nlsp-settings.nvim json settings
    },                  -- override any of the default settings here
})

local ensure_installed = {}
if vim.fn.has('win32') then
    ensure_installed = {
        'lua_ls',
        'rust_analyzer',
    }
else
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
        'rust_analyzer',
        'taplo',
        'tsserver',
    }
end

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = ensure_installed,
    automatic_installation = true,
})


local lua_check_third_party = true
if vim.fn.has('win32') then
    lua_check_third_party = false
end

--vim.lsp.set_log_level 'debug'
--vim.lsp.start({
--    cmd = { "/home/gijsk/rust/test_lsp/target/debug/test_lsp" },
--    root_dir = vim.fn.getcwd(), -- Use PWD as project root dir.
--})
local configs = require('lspconfig.configs')
if not configs.test_lsp then
    configs.test_lsp = {
        default_config = {
            cmd = { '/home/gijsk/rust/test_lsp/target/debug/test_lsp' },
            filetypes = { 'rust' },
            --            root_dir = function(fname)
            --                return lspconfig.util.find_git_ancestor(fname)
            --            end,
            settings = {},
            single_file_support = true,
        },
    }
end

-- luasnip setup
local luasnip = require 'luasnip'

local cmp = require('cmp')

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<C-c>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
    ["<CR>"] = cmp.mapping({
        i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
                fallback()
            end
        end,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    }),

    ['<C-x>'] = cmp.mapping(
        cmp.mapping.complete({
            config = {
                sources = cmp.config.sources({
                    { name = 'cmp_tabnine', priority = 9 },
                })
            }
        }),
        { 'n', 'i' }
    ),
})

--cmp_mappings['<Tab>'] = nil
--cmp_mappings['<S-Tab>'] = nil

cmp.setup({

    sorting = {
        priority_weight = 1.0,
        comparators = {
            require('cmp_tabnine.compare'),
            -- compare.score_offset, -- not good at all
            compare.locality,
            compare.recently_used,
            compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
            compare.offset,
            compare.order,
            -- compare.scopes, -- what?
            -- compare.sort_text,
            -- compare.exact,
            -- compare.kind,
            -- compare.length, -- useless
        },
    },
    --   sorting = {
    --       priority_weight = 2,
    --       comparators = {
    --           compare.offset,
    --           compare.exact,
    --           compare.score,
    --           compare.recently_used,
    --           compare.kind,
    --           compare.sort_text,
    --           compare.length,
    --           compare.order,
    --       },
    --   },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "cmp_tabnine",            priority = 9 },
        { name = "buffer" },
        { name = "nvim_lsp",               priority = 8 },
        { name = "nvim_lsp_signature_help" },
        { name = "crates" },
        { name = "luasnip" },
    },
    mapping = cmp_mappings,
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({
                mode = "symbol_text",
                maxwidth = 50,
                menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[Latex]",
                    cmp_tabnine = "T9",
                })
            })(entry, vim_item)
            --vim.print(vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            if vim_item.kind == " Codeium" or vim_item.kind == " TabNine" then
                kind.kind = " " .. kind.menu .. " "
            else
                kind.kind = " " .. (strings[1] or "") .. " "
            end
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
        end,
        --        format = lspkind.cmp_format({
        --            mode = "symbol_text",
        --            menu = ({
        --                buffer = "[Buffer]",
        --                nvim_lsp = "[LSP]",
        --                luasnip = "[LuaSnip]",
        --                nvim_lua = "[Lua]",
        --                latex_symbols = "[Latex]",
        --                cmp_tabnine = "[T9]",
        --            })
        --        }),
    },
    view = {
        entries = "custom" -- can be "custom", "wildmenu" or "native"
    },
    window = {
        completion = {
            --winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
        },
    },
})



--cmp.setup.cmdline('/', {
--    view = {
--        entries = { name = 'wildmenu', separator = '|' }
--    },
--})

--lsp.setup_nvim_cmp({
--    mapping = cmp_mappings
--})

--lsp.set_preferences({
--    suggest_lsp_servers = false,
--    sign_icons = {
--        error = 'F',
--        warn = 'G',
--        hint = 'H',
--        info = 'I'
--    }
--})


---
-- Diagnostics
---

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



local on_attach = function(client, buffer, rust)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = buffer, remap = false, desc = desc })
    end
    if rust then
        nmap("<leader>vem", function() vim.cmd.RustLsp('expandMacro') end, "expand macro")
        --nmap('<leader>ca', rust_tools.hover_actions.hover_actions, "hover actions")
        nmap("<leader>vrd", function() vim.cmd.RustLsp('renderDiagnostic') end, "render diagnostic")
        nmap("<leader>ca", function() vim.cmd.RustLsp { 'hover', 'actions' } end, "hover actions")
        nmap("<leader>vca", function() vim.cmd.RustLsp('codeAction') end, "code action")
    elseif client ~= nil and client.server_capabilities ~= nil and client.server_capabilities.codeActionProvider then
        nmap("<leader>vca", function() vim.lsp.buf.code_action() end, "code action")
    else
        nmap("<leader>vca", function() end, "code action not available")
    end
    nmap("gD", function() vim.lsp.buf.declaration() end, "declaration")
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

local on_attach_mason = function(ev, rust)
    local client
    if ev.data ~= nil then
        client = vim.lsp.get_client_by_id(ev.data.client_id)
    end
    local buffer = ev.buf
    on_attach(client, buffer, rust)
end


vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        on_attach(ev, false)
        --    -- Enable completion triggered by <c-x><c-o>
        --    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        --
    end,
})

vim.diagnostic.config({
    virtual_text = true
})

local rust_analyzer =
{
    restartServerOnConfigChange = true,
    cargo = {
        loadOutDirsFromCheck = true,
    },
    checkOnSave = {
    },
    check = {
        allTargets = false,
        --        extraArgs = { "--locked", "-j2" },
        --overrideCommand = { "cargo", "clippy", "--workspace", "--message-format=json", "--", "-W",
        --    "clippy::pedantic" },
    },
    procMacro = {
        enable = true,
    },
    diagnostics = {
        enable = true,
        disabled = { "unresolved-proc-macro" },
        --        experimental = {
        --            enable = true
        --        },
    },
    lru = {
        capacity = 512,
    }
}
--local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())


require('mason-lspconfig').setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = lsp_capabilities,
            --                root_dir = vim.lsp.buf.list_workspace_folders,
        })
    end,
    ["rust_analyzer"] = function()
    end,
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
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
                },
            },
        }
    end

})

vim.diagnostic.config({
    severity_sort = true,
    virtual_text = {
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
        }
    }
})

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
        on_attach = function(client, bufnr)
            on_attach(client, bufnr, true)
        end,
        --on_attach = function(client, bufnr)
        -- you can also put keymaps in here
        --end,
        default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = rust_analyzer,
        },
    },
    -- DAP configuration
    --dap = {
    --},
}

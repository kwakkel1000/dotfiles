local rust_tools = require('rust-tools')
local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local compare = require('cmp.config.compare')

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
                    { name = 'codeium',     priority = 10 },
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
        --{ name = "codeium",                priority = 10 },
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
                    codeium = "",
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
        --                codeium = "[]",
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



--local on_attach = function(client, bufnr)
local on_attach = function(ev, rust)
    local opts = { buffer = ev.buf, remap = false }
    opts.desc = "hover actions"
    if rust then
        vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, opts)
    end
    opts.desc = "declaration"
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    opts.desc = "definition"
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    opts.desc = "hover"
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    opts.desc = "mplementation"
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    opts.desc = "workspace symbol"
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    opts.desc = "open float"
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    opts.desc = "diagnostic next"
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    opts.desc = "diagnostic prev"
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    opts.desc = "code action"
    vim.keymap.set({ 'n', 'v' }, "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    opts.desc = "references"
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    opts.desc = "rename"
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    opts.desc = "signature help"
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
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
        require("rust-tools").setup {
            tools = {
                runnables = {
                    use_telescope = true,
                },
                inlay_hints = {
                    auto = true,
                    --            show_parameter_hints = false,
                    --            parameter_hints_prefix = "",
                    --            other_hints_prefix = "blub",
                    --            highlight = "Red",

                },
                hover_actions = {
                    auto_focus = true
                },
            },
            server = {
                capabilities = lsp_capabilities,
                on_attach = function(ev)
                    on_attach(ev, true)
                end,
                standalone = false,
                settings = {
                    -- to enable rust-analyzer settings visit:
                    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                    ["rust-analyzer"] = rust_analyzer
                },
            },
            dap = {
                adapter = {
                    type = "executable",
                    command = "lldb-vscode",
                    name = "rt_lldb"
                }
            }
        }
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

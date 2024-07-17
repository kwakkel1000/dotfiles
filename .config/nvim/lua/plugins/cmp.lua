return {
    -- Autocompletion
    {
        "L3MON4D3/LuaSnip",
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local luasnip = require 'luasnip'

            local cmp = require('cmp')
            local compare = cmp.config.compare

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
                                --{ name = 'cmp_tabnine', priority = 9 },
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
        end
    },
    { "hrsh8th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { "hrsh7th/cmp-nvim-lua" },
}

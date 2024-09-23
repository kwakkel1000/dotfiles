-- register all text objects with which-key
-- https://github.com/LazyVim/LazyVim/blob/3a87ce4afb3a780be14fe3efcd7924570285538c/lua/lazyvim/util/mini.lua#L64
-- TODO: yanking inside text objects like functions (cfr. LazyVim config) -- some of the below definitions do not seem to work yet
---@param opts table
local function ai_whichkey(opts)
    local objects = {
        -- Default WYSIWYG bindings
        { '"', desc = '" string' },
        { "'", desc = "' string" },
        { "`", desc = "` string" },
        { "(", desc = "() block" },
        { ")", desc = "() block with ws" },
        { "[", desc = "[] block" },
        { "]", desc = "[] block with ws" },
        { "{", desc = "{} block" },
        { "}", desc = "{} block with ws" },
        { "<", desc = "<> block" },
        { ">", desc = "<> block with ws" },
        { "?", desc = "user prompt" },
        -- Default concept bindings
        { " ", desc = "non-whitespace" },
        { "_", desc = "underscore" },
        { "a", desc = "argument" },
        { "b", desc = ")]} block" },
        { "u", desc = "use/call" }, -- f in default config
        { "U", desc = "use/call without dot" },
        { "q", desc = "quote `\"'" },
        { "t", desc = "tag" },
        -- Custom (from Lazy.nvim)
        { "c", desc = "class" },
        { "d", desc = "digit(s)" },
        { "f", desc = "function treesitter" },
        { "o", desc = "block, conditional, loop" },
    }
    local ret = { mode = { "o", "x" } }
    ---@type table<string, string>
    local mappings = vim.tbl_extend("force", {}, {
        around = "a",
        inside = "i",
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",
    }, opts.mappings or {})
    for name, prefix in pairs(mappings) do
        name = name:gsub("^around_", ""):gsub("^inside_", "")
        ret[#ret + 1] = { prefix, group = name }
        for _, obj in ipairs(objects) do
            local desc = obj.desc
            if prefix:sub(1, 1) == "a" then
                desc = desc:gsub(" with ws", "")
            end
            ret[#ret + 1] = { prefix .. obj[1], desc = desc }
        end
    end
    require("which-key").add(ret, { notify = false })
    local ret_go = { mode = { "n" } }
    ---@type table<string, string>
    local mappings_go = vim.tbl_extend("force", {}, {
        goto_left = "g[",
        goto_right = "g]",
    }, opts.mappings or {})
    for name, prefix in pairs(mappings_go) do
        ret_go[#ret_go + 1] = { prefix, group = name }
        for _, obj in ipairs(objects) do
            local desc = obj.desc
            desc = desc:gsub(" with ws", "")
            ret_go[#ret_go + 1] = { prefix .. obj[1], desc = desc }
        end
    end
    require("which-key").add(ret_go, { notify = false })
end
--  Check out: https://github.com/echasnovski/mini.nvim
return {
    "echasnovski/mini.nvim",
    dependencies = {
        -- Custom textobjects found through treesitter
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        local spec_treesitter = require("mini.ai").gen_spec.treesitter
        require("mini.ai").setup({
            n_lines = 500,
            -- Allow searching for function names and control flow constructs using treesitter
            custom_textobjects = {
                c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
                d = { "%f[%d]%d+" },                                             -- digits
                f = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
                o = spec_treesitter({
                    a = { "@conditional.outer", "@loop.outer" },
                    i = { "@conditional.inner", "@loop.inner" },
                }),
                u = require("mini.ai").gen_spec.function_call(),                           -- u for "Usage" - overwrites normal `f`
                U = require("mini.ai").gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
            },
        })
        ai_whichkey({})
        -- require("mini.pairs").setup()
        --  NOTE: using `nvim-surround` rather than `mini.surround`, because the keybinds can differ between visual and normal mode
    end,
}

local wk = require("which-key")


wk.register({
    ["<leader>"] = {
        g = { name = "git" },
        p = { name = "file" },
        x = { name = "trouble" },
        t = { name = "terminal" },
        z = { name = "zen mode" },
    }
})

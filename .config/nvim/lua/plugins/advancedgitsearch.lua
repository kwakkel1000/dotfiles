return {
    "aaronhallaert/advanced-git-search.nvim",
    config = function()
        require("telescope").load_extension("advanced_git_search")
    end,
    requires = {
        -- Insert Dependencies here
    },
}

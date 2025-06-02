vim.filetype.add({
    pattern = {
        -- For `yaml` lsp to recognize helm files
        [".*/templates/.*%.ya?ml"] = "helm",
        [".*/templates/.*%.tpl"] = "helm",
        [".*/templates/.*%.txt"] = "helm",
        [".*helmfile.*%.ya?ml"] = "helm",
        -- Activate TS on jenkins files (lsp does not work right now)
        ["Jenkinsfile.*"] = "groovy",
    },
})

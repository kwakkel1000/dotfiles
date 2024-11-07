return {
    {
        'https://gitlab.com/itaranto/preview.nvim',
        version = '*',
        opts = {
            previewers_by_ft = {
                plantuml = {
                    name = 'plantuml_svg',
                    renderer = { type = 'imv' },
                },
            },
            previewers = {
                plantuml_svg = {
                    args = { '-pipe', '-tpng' },
                },
            },
            render_on_write = true,
        },
    },
    {
        'https://github.com/aklt/plantuml-syntax'
    }
}

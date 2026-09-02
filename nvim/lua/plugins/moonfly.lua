return {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    config = function()
        vim.g.moonflyTransparent = false -- true for transparent background
        vim.g.moonflyItalics = true
        vim.g.moonflyNormalFloat = true

        require("moonfly").custom_colors({
            bg = "#000000",
            white = "#e0e0e0",
            sky = "#8ac8ff",
            khaki = "#d8de8a",
            violet = "#dda0f5",
            emerald = "#42ddb0",
            turquoise = "#88e8d6",
            green = "#a0e070",
            orange = "#f0a868",
            cranberry = "#ff7088",
            purple = "#b898ff",
            lavender = "#b8b8ff",
            orchid = "#f0a0b0",
        })
        -- Not auto-applied; kanagawa is the active theme. Run :colorscheme moonfly to switch.
    end,
}

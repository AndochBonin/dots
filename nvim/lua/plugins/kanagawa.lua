return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        theme = "dragon",
        background = {
            dark = "dragon",
            light = "lotus",
        },
    },
    config = function(_, opts)
        require("kanagawa").setup(opts)
        vim.cmd.colorscheme("kanagawa")

        -- LspFloat groups referenced by the K hover keymap in config/lazy.lua
        local function set_lsp_float_hl()
            vim.api.nvim_set_hl(0, "LspFloat", { link = "NormalFloat" })
            vim.api.nvim_set_hl(0, "LspFloatBorder", { link = "FloatBorder" })
        end
        vim.api.nvim_create_autocmd("ColorScheme", { callback = set_lsp_float_hl })
        set_lsp_float_hl()
    end,
}

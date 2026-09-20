return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    -- build = ":TSUpdate",
    config = function()
        vim.filetype.add({ extension = { mq5 = "mql5", mqh = "mql5" } })
        vim.treesitter.language.register("cpp", "mql5")
        require("nvim-treesitter").setup()
        require("nvim-treesitter").install({ "go", "bash", "cpp", "lua" })
    end,
}

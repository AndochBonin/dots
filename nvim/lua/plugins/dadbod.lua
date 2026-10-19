return {
    {
        "tpope/vim-dadbod",
        "kristijanhusak/vim-dadbod-ui",
        "kristijanhusak/vim-dadbod-completion",
    },
    vim.keymap.set({ "n" }, "<leader>db", "<CMD>DBUI<CR>", { silent = true })
}

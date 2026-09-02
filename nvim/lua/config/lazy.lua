-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "just guess",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

require("config.file-sync")

vim.o.updatetime = 250

local suppress_diag_float = false

local function close_diag_float()
    local win = vim.b.lsp_floating_preview
    if win and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
        vim.b.lsp_floating_preview = nil
        return true
    end
    return false
end

local function show_diag_float()
    if suppress_diag_float then
        return
    end
    vim.diagnostic.open_float(nil, { focus = false })
end

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = show_diag_float,
})

vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
        suppress_diag_float = false
    end,
})

vim.keymap.set("n", "<Esc>", function()
    if close_diag_float() then
        suppress_diag_float = true
    end
end, { desc = "Close diagnostic float" })

-- close lazy on esc
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lazy",
    callback = function(event)
        vim.keymap.set("n", "<Esc>", function()
            vim.api.nvim_win_close(0, true)
        end, { buffer = event.buf, nowait = true })
    end,
})

-- vim.opt.fillchars = { vert = "│" }
-- shift K get help tip, go to def, jk to go to normal mode
local open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    local winhighlight = opts.winhighlight
    local bufnr, winnr = open_floating_preview(contents, syntax, opts, ...)
    if winnr and winhighlight then
        vim.wo[winnr].winhighlight = winhighlight
    end
    return bufnr, winnr
end

vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover({
        border = "single",
        winhighlight = "NormalFloat:LspFloat,Normal:LspFloat,FloatBorder:LspFloatBorder",
    })
end, { desc = "LSP hover" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>td", ":Td<CR>", { silent = true })
vim.keymap.set("n", "<leader>tt", ":FloatTerminal<CR>", { silent = true, desc = "Toggle floating terminal" })

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },

    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "kanagawa" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

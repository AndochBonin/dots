return {
    {
        "mason-org/mason.nvim",
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "gopls", "vimls" }
        },
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },

        config = function()
            -- Lua LS config (new API)
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            -- enable servers
            vim.lsp.enable({
                "lua_ls",
                "gopls",
                "vimls",
            })
        end,
    }
}

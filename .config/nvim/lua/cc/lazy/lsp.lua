-- KEYBINDS SET IN ../init.lua

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        { -- sets up vim global var
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    config = function()
        -- keybind to kill lsp
        vim.keymap.set("n", "<leader>lk",
            function()
                local clients = vim.lsp.get_clients()

                for _, client in pairs(clients) do
                    client.stop()
                end
            end
        )

        local cmp = require("cmp")
        local cmd_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmd_lsp.default_capabilities()
        )

        -- require("fidget").setup()
        require("mason").setup({ })

        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "clangd",
            },
            handlers = {
                function(server) -- default handler
                    require("lspconfig")[server].setup({
                        capabilities = capabilities
                    })
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "it", "describe", "before_each", "after_each",
                                    "awesome", "client", "screen", "root", "tag"}
                                },
                                workspace = {
                                    library = {
                                        '/usr/share/nvim/runtime/lua',
                                        '/usr/share/nvim/runtime/lua/lsp',
                                        '/usr/share/awesome/lib'
                                    },
                                },
                                telemetry = { enable = false },
                            }
                        }
                    })
                end,
                ["clangd"] = function()
                    require("lspconfig").clangd.setup({
                        cmd = {
                            "clangd",
                            "--offset-encoding=utf-16",
                        }
                    })
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            })
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                header = "",
                prefix = ""
            }
        })
    end
}

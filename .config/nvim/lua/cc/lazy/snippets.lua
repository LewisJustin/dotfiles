return {
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            local ls = require("luasnip")
            local types = require("luasnip.util.types")
            vim.keymap.set({"i"}, "<Tab>", function() ls.jump(1) end, {})
            vim.keymap.set({"i"}, "<S-Tab>", function() ls.jump(1) end, {})

            ls.config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                -- enable_autosnippets = true,
                ext_opts = {
                    [types.choiceNode] = {
                        active = {
                            virt_text = { { "choiceNode", "Comment" } },
                        },
                    },
                },
            })
        end
    }
}

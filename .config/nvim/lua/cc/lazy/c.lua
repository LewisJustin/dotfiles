return { { -- formatter
    "nvimtools/none-ls.nvim", -- make config with: https://zed0.co.uk/clang-format-configurator/
    event = "VeryLazy",
    opts = function()
        local null_ls = require("null-ls")
        return {
            sources = {
                null_ls.builtins.formatting.clang_format,
            }
        }
    end,
    config = function()
        -- format buffer
        vim.keymap.set("v", "<leader>f", function()
            vim.lsp.buf.format()
        end)
    end,
}, {
        "mfussenegger/nvim-dap",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
        require("mason").setup({
            ensure_installed = {
                "codelldb",
            }
        })
        end
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            handlers = {},
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        plugin = true,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()

            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
            vim.keymap.set("n", "<leader>dr", dap.continue)
            vim.keymap.set("n", "<leader>ds", dap.step_over)
            vim.keymap.set("n", "<leader>di", dap.step_into)
            vim.keymap.set("n", "<leader>do", dap.step_out)

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    }
}

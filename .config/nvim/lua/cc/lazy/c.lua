return {
    {                    -- formatter
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
                vim.cmd("normal! ")
            end)

            vim.keymap.set("n", "<leader>ff", function()
                -- a bit silly, but select current line, then format it
                vim.cmd("normal! V")
                vim.lsp.buf.format()
                vim.cmd("normal! ")
            end)
        end,
    }, {
        "mfussenegger/nvim-dap",
        dependencies = {
            "williamboman/mason.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            require("mason").setup()
            -- make sure there's a c/c++ debugger installed
            require('mason-tool-installer').setup {
                ensure_installed = { "codelldb" }
            }
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            handlers = {
                function(config)
                    -- Keep original functionality
                    require('mason-nvim-dap').default_setup(config)
                end,
                codelldb = function(config)

                    config.adaptors = {
                        name = 'LLDB: Launch',
                        type = 'codelldb',
                        request = 'launch',
                        program = function()
                            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                        end,
                        cwd = '${workspaceFolder}',
                        stopOnEntry = false,
                        args = {},
                        console = 'integratedTerminal',
                        reverseDebugging = true,
                        -- targetCreateCommands = ["
                        -- TODO, figure out how to use rr to create recording,
                        -- then use targetCreateCommands/processCreateCommands
                        -- to debug based on the rr - recording. 
                        -- also, how to use mason to keep rr installed? 
                    }
                    require('mason-nvim-dap').default_setup(config) -- don't forget this!
                end,
            },
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
            vim.keymap.set("n", "<leader>dc", dap.run_to_cursor)
            vim.keymap.set("n", "<leader>dr", dap.continue)
            vim.keymap.set("n", "<leader>ds", dap.step_over)
            vim.keymap.set("n", "<leader>di", dap.step_into)
            vim.keymap.set("n", "<leader>do", dap.step_out)
            -- dap - time travel? 
            vim.keymap.set("n", "<leader>dt", dap.step_back)

            vim.keymap.set("n", "<leader>dq", dapui.close)

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

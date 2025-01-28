return {
    "nvim-telescope/telescope.nvim",
    dependencies = { {
        "nvim-lua/plenary.nvim",
        -- opts = {rocks = {hererocks = false}},
    },
    },
    config = function()
        require("telescope").setup({})
        local opts = { noremap = true, silent = true }

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, opts)
        vim.keymap.set("n", "<C-p>", builtin.git_files, opts)
        vim.keymap.set("n", "<leader>pws", function ()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>pWs", function ()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>ps", function ()
            -- builtin.grep_string({ search = vim.fn.input("Grep > ") })
            builtin.live_grep()
        end)

        vim.keymap.set("v", "<leader>ps", function ()
            local function getVisualSelection()
                vim.cmd('noau normal! "vy"')
                local text = vim.fn.getreg('v')
                vim.fn.setreg('v', {})

                text = string.gsub(text, "\n", "")
                if #text > 0 then
                    return text
                else
                    return ''
                end
            end -- getVisualSelection

            local search = getVisualSelection()

            builtin.grep_string({search = search})
        end)

        -- vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>ph", builtin.help_tags, {})

        -- send results to quickfix list
        vim.keymap.set("n", "<C-q>", function ()
            builtin.smart_send_to_qflist()
        end)
    end
}

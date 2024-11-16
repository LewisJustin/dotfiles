return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup()

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
        vim.keymap.set("n", "<C-p>", builtin.git_files, {})
        vim.keymap.set("n", "<leader>pws", function ()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>pWs", function ()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>ps", function ()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        -- vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>ph", builtin.help_tags, {})

        -- send results to quickfix list
        vim.keymap.set("n", "<C-q>", function ()
            builtin.smart_send_to_qflist()
        end)
    end
}

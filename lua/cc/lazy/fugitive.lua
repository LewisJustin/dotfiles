return {
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

            local CC_Fugitive = vim.api.nvim_create_augroup("CC_Fugitive", {})

            local autocmd = vim.api.nvim_create_autocmd
            autocmd("BufWinEnter", {
                group = CC_Fugitive,
                pattern = "*",
                callback = function()
                    if vim.bo.ft ~= "fugitive" then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local opts = { buffer = bufnr, remap = false }
                    -- vim.keymap.set("n", "<leader>h", function() vim.cmd.Git("help") end, opts)
                    vim.keymap.set("n", "<leader>gc", function() vim.cmd.Git("commit") end, opts)
                    vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git("push") end, opts)
                    vim.keymap.set("n", "<leader>gP", function() vim.cmd.Git("pull") end, opts)
                end
            })
        end
    }
}

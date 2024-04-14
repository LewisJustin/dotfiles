return {
    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

    { "Exafunction/codeium.vim", config = function()
        vim.cmd("Codeium Disable") -- disable by default, opt into assistance

        vim.keymap.set("n", "<leader>ct", function() vim.cmd("Codeium Toggle") end)
    end },
}

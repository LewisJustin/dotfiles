vim.keymap.set("n", "<leader>rc", function()
    RunInFloat("%!make 1>/dev/null && ./build/app")
end)

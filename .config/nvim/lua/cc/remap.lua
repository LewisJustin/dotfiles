vim.g.mapleader = " "
-- terminal mode
-- better escape
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-K>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-q>", "<C-\\><C-N>:q<CR>")

-- arrows resize windows
vim.keymap.set("n", "<Up>", ":resize +2<CR>")
vim.keymap.set("n", "<Down>", ":resize -2<CR>")
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>")

-- open
vim.keymap.set("n", "<leader>ot", ":split term://bash<CR>a")
-- source $MYVIMRC
vim.keymap.set("n", "<leader>rc", ":source $MYVIMRC<CR>")

-- disable treesitter in help
vim.keymap.set("n", "<leader>h", ":set invhls<CR>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- shift selection up/down, appropriate tabbing
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- bring next line up w/o moving cursor
vim.keymap.set("n", "J", "mzJ`z")
-- ctrl d and u will keep cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- search terms stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste over visual selection w/o losing paste register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- quick yank into system clipboard : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete without going into std register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- consistent behavior between esc and ctrl c
vim.keymap.set("i", "<C-c>", "<Esc>")

-- disable shortcut to weird mode
vim.keymap.set("n", "Q", "<nop>")

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- quick fix list navigation
vim.keymap.set("n", "<leader>n", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>p", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "", "<cmd>lprev<CR>zz")

-- replace word you were on
-- TODO, substitute with a smarter LSP based token rename
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- quick edit packer.lua
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");

-- shoutout current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

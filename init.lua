require("cc")

-- for running from ftplugins
local function window_config()
    local ui = vim.api.nvim_list_uis()[1]
    local winWidth = math.ceil(ui.width * 0.8)
    local winHeight = math.ceil(ui.height * 0.8)
    return {
        relative = 'editor',
        width = winWidth,
        height = winHeight,
        col = math.ceil(ui.width/2 - winWidth / 2),
        row = math.ceil(ui.height/2 - winHeight / 2),
        anchor = 'NW',
        style = 'minimal',
        -- border = 'single'
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    }
end

local function createBuffer()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', { noremap = true, silent = true; nowait = true})
    vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', ':close<CR>', { noremap = true, silent = true; nowait = true})
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Leader>', ':close<CR>', { noremap = true, silent = true; nowait = true})
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true; nowait = true})
    return buf
end

function RunInFloat(arg)
    local buf = createBuffer()
    vim.api.nvim_open_win(buf, true, window_config())
    vim.api.nvim_command(arg)
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
end


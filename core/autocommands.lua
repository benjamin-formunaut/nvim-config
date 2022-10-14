local packer = require("packer")
local settings = require("settings")

-- reload config on changes
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = "*/.config/nvim/*",
    group = vim.api.nvim_create_augroup("reload_config", { clear = true }),
    callback = require("utils").refresh_config,
})

-- sync plugins on change
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = "plugins.lua",
    group = vim.api.nvim_create_augroup("reload_config", { clear = true }),
    callback = function()
        packer.install()
        packer.sync()
    end,
})

-- notify when the current file is not in utf-8
vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern = "*",
    group = vim.api.nvim_create_augroup("non_utf8_file", { clear = true }),
    callback = function()
        if vim.bo.fileencoding ~= "utf-8" then
            vim.notify("File not in UTF-8 format!", vim.log.levels.WARN, { title = "nvim-config" })
        end
    end,
})

-- return to last cursor position when opening a file
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = "*",
    group =  vim.api.nvim_create_augroup("resume_cursor_position", { clear = true }),
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]
})

-- highlight yanked region, see `:h lua-highlight`
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = "*",
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank { higroup = "IncSearch", timeout = 300 }
    end,
})


-- resize all windows when we resize the terminal
vim.api.nvim_create_autocmd("VimResized", {
    group = vim.api.nvim_create_augroup("win_autoresize", { clear = true }),
    command = "wincmd =",
})


-- quit nvim if we have only one window, and its filetype match our pattern.
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("auto_close_win", { clear = true }),
    callback = function()
        local should_quit = true

        local tabwins = vim.api.nvim_tabpage_list_wins(0)
        for _, window in ipairs(tabwins) do
            local buffer = vim.api.nvim_win_get_buf(window)
            local file_type = vim.fn.getbufvar(buffer, "filetype")
            if not vim.tbl_contains(settings.quit_filetypes, file_type) then
                should_quit = false
            end
        end
        if should_quit then
            vim.cmd([[qall]])
        end
    end
})

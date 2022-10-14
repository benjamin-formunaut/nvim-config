local M = {}

function M.init()
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = "*/.config/nvim/**",
        group = vim.api.nvim_create_augroup("reload_config", { clear = true }),
        callback = function(args)
            require("bmmvim.utils").reload_config()
            if vim.endswith(args.file, "plugins.lua") then
                require("bmmvim.plugin_manager").sync()
            end
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
end

return M

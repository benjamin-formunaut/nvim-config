local ok, auto_save = pcall(require, "auto-save")
if not ok then
    return
end

local options = {
    debounce_delay = 1000,
    condition = function(bufnr)
        local utils = require("auto-save.utils.data")

        if
            vim.fn.getbufvar(bufnr, "&modifiable") == 1
            and utils.not_in(vim.fn.getbufvar(bufnr, "&filetype"), {})
            -- never autosave in nvim config
            and vim.fn.getcwd() ~= vim.fn.stdpath("config")
            -- only autosave when inside git repos
            and require("bmmvim.utils").inside_git_repo()
        then
            return true
        end
        return false
    end,
}

auto_save.setup(options)

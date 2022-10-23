local ok, attempt = pcall(require, "attempt")
if not ok then
    return
end

local utils = require("bmmvim.utils")

local get_manage_py = function()
    local manage_py = vim.fn.getcwd() .. "/manage.py"
    if utils.file_exists(manage_py) then
        return manage_py
    end
    return false
end

local options = {
    dir = "./.nvim_scratch/",
    ext_options = { "lua", "py", "" },
    initial_content = {
        py = "",
    },
    run = {
        py = function(_, bufnr)
            local manage_py = get_manage_py()
            local file_path = vim.api.nvim_buf_get_name(bufnr)
            local cmd
            if manage_py then
                cmd = "w !" .. manage_py .. " shell < " .. file_path
            else
                cmd = "w !python"
            end
            vim.cmd(cmd)
        end,
    },
}

attempt.setup(options)

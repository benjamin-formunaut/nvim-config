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


local terminal = nil
local present, toggleterm_terminal = pcall(require, "toggleterm.terminal")
if present then
    terminal = toggleterm_terminal.Terminal:new({ hidden = true })
end

local run = function(cmd)
    if terminal ~= nil then
        terminal:open()
        terminal:send(cmd, true)
    else
        vim.cmd("!" .. cmd)
    end
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
                cmd = manage_py .. " shell < " .. file_path
            else
                cmd = "python " .. file_path
            end
            run(cmd)
        end,
    },
}

attempt.setup(options)

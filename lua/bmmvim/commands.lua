local M = {}

local utils = require("bmmvim.utils")

function M.init()
    -- refresh config
    vim.api.nvim_create_user_command("Reload", utils.reload_config, {nargs = 0})

    -- open git gutter changes
    vim.api.nvim_create_user_command("Gqf", "GitGutterQuickFix | copen", {nargs = 0})
    vim.api.nvim_create_user_command("Gqfcf", "GitGutterQuickFixCurrentFile | copen", {nargs = 0})
end

return M

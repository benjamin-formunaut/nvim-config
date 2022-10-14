utils = require("utils")

-- refresh config
vim.api.nvim_create_user_command("Refresh", utils.refresh_config, {nargs = 0})

-- open git gutter changes
vim.api.nvim_create_user_command("Gqf", "GitGutterQuickFix | copen", {nargs = 0})
vim.api.nvim_create_user_command("Gqfcf", "GitGutterQuickFixCurrentFile | copen", {nargs = 0})

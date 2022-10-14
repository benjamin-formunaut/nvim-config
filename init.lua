local utils = require("utils")

-- check if we have the latest stable version of nvim
local expected_ver = "0.8.0"
local nvim_ver = utils.get_nvim_version()

if nvim_ver ~= expected_ver then
  local msg = string.format("Unsupported nvim version: expect %s, but got %s instead!", expected_ver, nvim_ver)
  vim.api.nvim_err_writeln(msg)
  return
end

local core_conf_files = {
  "globals.lua",            -- some global settings
  "options.lua",            -- setting options in nvim
  "plugin_management.lua",  -- all the plugins installed and their configurations
  "commands.lua",           -- custom commands
  "autocommands.lua",       -- various autocommands
  "keymaps.lua",            -- all the user-defined mappings
  "colorschemes.lua",       -- colorscheme settings
}

-- source all the core config files
for _, name in ipairs(core_conf_files) do
  local path = string.format("%s/core/%s", vim.fn.stdpath("config"), name)
  local source_cmd = "source " .. path
  vim.cmd(source_cmd)
end

local utils = require("utils")

-- inspect something
function _G.inspect(item)
  vim.pretty_print(item)
end


------------------------------------------------------------------------
-- Builtin Variables
------------------------------------------------------------------------

if utils.executable("python3") then
    vim.g.python3_host_prog = vim.fn.exepath("python3")
else
  vim.api.nvim_err_writeln("Python3 executable not found! You must install Python3 and set its PATH correctly!")
  return
end

-- custom mapping <leader> (see `:h mapleader` for more info)
-- ref https://stackoverflow.com/questions/446269/can-i-use-space-as-mapleader-in-vim
vim.keymap.set("n", "<SPACE>", "<Nop>")
vim.g.mapleader = " "

-- enable highlighting embedded lua and python
vim.g.vimsyn_embed = "lP"

-- use english as main language
vim.cmd [[language en_GB.UTF-8]]

-- the root dir to install all plugins. plugins are under opt/ or start/ sub-directory.
vim.g.plugin_home = vim.fn.stdpath("data") .. "/site/pack/packer"

-- where to install packer.nvim -- the package manager (we make it opt)
local packer_dir = vim.g.plugin_home .. "/start/packer.nvim"

-- whether this is a fresh install, i.e., packer itself and plugins have not been installed.
local fresh_install = false

-- auto-install packer in case it hasn't been installed.
if vim.fn.glob(packer_dir) == "" then
    fresh_install = true

    -- now we need to install packer.nvim first.
    local packer_repo = "https://github.com/wbthomason/packer.nvim"
    local install_cmd = string.format("!git clone --depth=1 %s %s", packer_repo, packer_dir)

    vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
    vim.cmd(install_cmd)
end

-- load packer.nvim
vim.cmd("packadd packer.nvim")

local packer = require("packer")
local packer_util = require("packer.util")

packer.startup {
    require("plugins").startup,
    config = {
        max_jobs = 16,
        compile_path = packer_util.join_paths(vim.fn.stdpath("data"), "site", "lua", "packer_compiled.lua"),
    },
}

-- for fresh install, we need to install plugins. otherwise, we just need to require `packer_compiled.lua`.
if fresh_install then
    -- we run packer.sync() here, because only after packer.startup, can we know which plugins to install.
    -- so plugin installation should be done after the startup process.
    packer.sync()
else
    local status, _ = pcall(require, "packer_compiled")
    if not status then
        local msg = "File packer_compiled.lua not found: run PackerSync to fix!"
        vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })
    end
end

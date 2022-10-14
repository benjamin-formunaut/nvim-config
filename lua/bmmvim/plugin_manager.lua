local M = {}

local function install()
    -- the root dir to install all plugins. plugins are under opt/ or start/ sub-directory.
    vim.g.plugin_home = vim.fn.stdpath("data") .. "/site/pack/packer"

    -- where to install packer.nvim -- the package manager (we make it opt)
    local install_path = vim.g.plugin_home .. "/start/packer.nvim"

    -- whether this is a fresh install, i.e., packer itself and plugins have not been installed.
    local fresh_install = false

    -- auto-install packer in case it hasn't been installed.
    if vim.fn.glob(install_path) == "" then
        fresh_install = true

        -- now we need to install packer.nvim first.
        local packer_url = "https://github.com/wbthomason/packer.nvim"
        vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
	-- local install_cmd = string.format("!git clone --depth=1 %s %s", packer_url, install_path)
	-- vim.cmd(install_cmd)
        vim.fn.system {"git", "clone", "--depth", "1", packer_url, install_path}
    end
    return fresh_install
end

local function startup(plugins, fresh_install)
    vim.cmd("packadd packer.nvim")

    local packer = require("packer")
    local packer_util = require("packer.util")

    local packer_opts = {
        function(use)
            local plugins = require("bmmvim.plugins")
            for _, plugin in ipairs(plugins) do
                use(plugin)
            end
        end,
        config = {
            max_jobs = 16,
            compile_path = packer_util.join_paths(vim.fn.stdpath("data"), "site", "lua", "packer_compiled.lua"),
        },
    }

    packer.startup(packer_opts)

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
end

function M.init(plugins)
    local fresh_install = install()
    startup(plugins, fresh_install)
end

function M.sync()
    require("packer").sync()
end

return M

local plugins = {
    -- packer can manage itself
    {"wbthomason/packer.nvim"},

    -- better syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require "bmmvim.plugins.configs.treesitter"
        end,
    },
    {   -- fixes python autoindentation
        -- ref https://github.com/nvim-treesitter/nvim-treesitter/issues/1136#issuecomment-1127145770
        "yioneko/nvim-yati",
        requires = "nvim-treesitter/nvim-treesitter",
        after = "nvim-treesitter",
    },

    -- autopairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require "bmmvim.plugins.configs.autopairs"
        end,
    },

    -- comments
    {"tpope/vim-commentary"},

    -- info lines
    {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
        config = function()
            require "bmmvim.plugins.configs.lualine"
        end,
    },
    {
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require "bmmvim.plugins.configs.bufferline"
        end,
    },

    -- show indentation level
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require "bmmvim.plugins.configs.indent_blankline"
        end,
    },

    -- manage keybinds
    {
        "folke/which-key.nvim",
        config = function()
            require "bmmvim.plugins.configs.which_key"
        end,
    },

    -- finding things
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require "bmmvim.plugins.configs.telescope"
        end,
    },

    -- file explorer
    {
        "nvim-tree/nvim-tree.lua",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require "bmmvim.plugins.configs.nvim_tree"
        end,
    },

    -- lsp
    {
        "williamboman/mason.nvim",
        config = function()
            require "bmmvim.plugins.configs.mason"
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        after = {"mason.nvim", "which-key.nvim"},
        config = function()
            require "bmmvim.plugins.configs.mason_lspconfig"
        end,
    },
    {
        "neovim/nvim-lspconfig",
        after = {"mason-lspconfig.nvim", "cmp-nvim-lsp"},
        config = function()
            require "bmmvim.plugins.configs.lspconfig"
        end,
    },

    -- autocompletion & snippets
    {
        "rafamadriz/friendly-snippets",
    },
    {
        "hrsh7th/nvim-cmp",
        after = "friendly-snippets",
        config = function()
            require "bmmvim.plugins.configs.cmp"
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        after = "nvim-cmp",
        tag = "v1.*",
        config = function()
            require "bmmvim.plugins.configs.luasnip"
        end,
    },
    {
        "saadparwaiz1/cmp_luasnip",
        after = "LuaSnip"
    },
    {
        "hrsh7th/cmp-nvim-lua",
        after = "cmp_luasnip",
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        after = "cmp-nvim-lua",
    },
    {
        "hrsh7th/cmp-buffer",
        after = "cmp-nvim-lsp",
    },
    {
        "hrsh7th/cmp-path",
        after = "cmp-buffer",
    },
    {
        "hrsh7th/cmp-calc",
        after = "cmp-path",
    },

    -- respect editorconfig
    {
        "gpanders/editorconfig.nvim",
    },

    -- make it pretty
    {
        "sainnhe/sonokai",
        config = function()
            vim.cmd "colorscheme sonokai"
        end,
    },
}

local config = {
    auto_clean = true,
    compile_on_sync = true,
    compile_path = vim.fn.stdpath("data") .. "/site/lua/packer_compiled.lua",
    display = {
        working_sym = "ﲊ",
        error_sym = "✗ ",
        done_sym = " ",
        removed_sym = " ",
        moved_sym = "",
        open_fn = function()
            return require("packer.util").float { border = "single" }
        end,
    },
}

local function ensure_packer()
    -- the root dir to install all plugins. plugins are under opt/ or start/ sub-directory.
    vim.g.plugin_home = vim.fn.stdpath("data") .. "/site/pack/packer"

    -- where to install packer.nvim -- the package manager (we make it opt)
    local install_path = vim.g.plugin_home .. "/start/packer.nvim"

    local fresh_install = vim.fn.glob(install_path) == ""

    if fresh_install then
        vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
        vim.fn.system {"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path}
    end
    return fresh_install
end

local function startup(fresh_install)
    vim.cmd("packadd packer.nvim")

    local packer = require("packer")

    packer.startup({
        plugins,
        config=config,
    })

    if fresh_install then
        packer.sync()
    else
        local status, _ = pcall(require, "packer_compiled")
        if not status then
            vim.notify(
                "File packer_compiled.lua not found: run PackerSync to fix!",
                vim.log.levels.ERROR,
                { title = "nvim-config" }
            )
        end
    end
end

local M = {}

function M.init()
    local fresh_install = ensure_packer()
    startup(fresh_install)
end

function M.sync()
    require("packer").sync()
end

return M

local plugins = {

    -- packer can manage itself
    { "wbthomason/packer.nvim" },

    -- better syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("bmmvim.utils").configure_plugin("treesitter", { load_keys = false })
        end,
    },
    { -- fixes python autoindentation
        -- ref https://github.com/nvim-treesitter/nvim-treesitter/issues/1136#issuecomment-1127145770
        "yioneko/nvim-yati",
        requires = "nvim-treesitter/nvim-treesitter",
        after = "nvim-treesitter",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        requires = "nvim-treesitter/nvim-treesitter",
        after = "nvim-treesitter",
        config = function()
            require("bmmvim.utils").configure_plugin("treesitter_context", { load_keys = false })
        end
    },

    -- autopairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("bmmvim.utils").configure_plugin("autopairs", { load_keys = false })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        requires = "nvim-treesitter/nvim-treesitter",
        after = "nvim-treesitter",
        config = function()
            require("bmmvim.utils").configure_plugin("ts_autotag", { load_keys = false })
        end
    },

    -- comments
    {
        "tpope/vim-commentary",
    },

    -- info lines
    {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("bmmvim.utils").configure_plugin("lualine", { load_keys = false })
        end,
    },
    {
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("bmmvim.utils").configure_plugin("bufferline", { load_keys = false })
        end,
    },

    -- show indentation level
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("bmmvim.utils").configure_plugin("indent_blankline", { load_keys = false })
        end,
    },

    -- manage keybinds
    {
        "folke/which-key.nvim",
        config = function()
            require("bmmvim.utils").configure_plugin("which_key", { load_keys = false })
        end,
    },

    -- finding things
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("bmmvim.utils").configure_plugin("telescope")
        end,
    },

    -- file explorer
    {
        "nvim-tree/nvim-tree.lua",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bmmvim.utils").configure_plugin("nvim_tree")
        end,
    },

    -- lsp
    {
        "williamboman/mason.nvim",
        config = function()
            require("bmmvim.utils").configure_plugin("mason", { load_keys = false })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        after = { "mason.nvim", "which-key.nvim" },
        config = function()
            require("bmmvim.utils").configure_plugin("mason_lspconfig", { load_keys = false })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        after = { "mason-lspconfig.nvim", "cmp-nvim-lsp" },
        config = function()
            require("bmmvim.utils").configure_plugin("lspconfig")
        end,
    },

    -- autocompletion & snippets
    {
        "rafamadriz/friendly-snippets",
    },
    {
        "hrsh7th/nvim-cmp",
        after = "friendly-snippets",
        -- TODO: check if you wan't to put mappings in module
        config = function()
            require("bmmvim.utils").configure_plugin("cmp", { load_keys = false })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        after = "nvim-cmp",
        tag = "v1.*",
        config = function()
            require("bmmvim.utils").configure_plugin("luasnip", { load_keys = false })
        end,
    },
    {
        "saadparwaiz1/cmp_luasnip",
        after = "LuaSnip",
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
    {
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },

    -- linting & autoformmating
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("bmmvim.utils").configure_plugin("null_ls", { load_keys = false })
        end,
    },

    -- git
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("bmmvim.utils").configure_plugin("gitsigns", { load_keys = false })
        end,
    },
    {
        "tpope/vim-fugitive",
        config = function()
            require("bmmvim.utils").configure_plugin("fugitive", { load_module = false })
        end,
    },
    {
        "tpope/vim-rhubarb",
        requires = "vim-fugitive",
        config = function()
            require("bmmvim.utils").configure_plugin("rhubarb", { load_module = false })
        end,
    },

    -- respect editorconfig
    {
        "gpanders/editorconfig.nvim",
    },

    -- resize windows
    {
        "simeji/winresizer",
    },

    -- sane buffer killing
    {
        "moll/vim-bbye",
        config = function()
            require("bmmvim.utils").configure_plugin("bbye", { load_module = false })
        end,
    },

    -- sourroundings opperators
    {
        "machakann/vim-sandwich",
    },

    -- make it pretty
    {
        "sainnhe/sonokai",
        config = function()
            require("bmmvim.utils").configure_plugin("sonokai", { load_keys = false })
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
            return require("packer.util").float({ border = "single" })
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
        vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    end
    return fresh_install
end

local function startup(fresh_install)
    vim.cmd("packadd packer.nvim")

    local packer = require("packer")

    packer.startup({
        plugins,
        config = config,
    })

    if fresh_install then
        packer.sync()
    else
        local status, _ = pcall(require, "packer_compiled")
        if not status then
            vim.notify("File packer_compiled.lua not found: run PackerSync to fix!", vim.log.levels.ERROR)
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

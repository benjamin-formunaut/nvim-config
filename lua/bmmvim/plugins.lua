local plugins = {
    -- packer can manage itself
    {"wbthomason/packer.nvim"},

    -- better syntax highlighting
    {"nvim-treesitter/nvim-treesitter"},
    {   -- fixes python autoindentation
        -- ref https://github.com/nvim-treesitter/nvim-treesitter/issues/1136#issuecomment-1127145770
        "yioneko/nvim-yati",
        requires = "nvim-treesitter/nvim-treesitter",
    },

    -- autopairs
    {"windwp/nvim-autopairs"},

    -- comments
    {"tpope/vim-commentary"},

    -- line
    {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
    },
    {
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
    },

    -- show indentation level
    {"lukas-reineke/indent-blankline.nvim"},

    -- manage keybinds
    {"folke/which-key.nvim"},

    -- finding things
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = "nvim-lua/plenary.nvim",
    },

    -- file explorer
    {
        "nvim-tree/nvim-tree.lua",
        requires = "nvim-tree/nvim-web-devicons",
    },

    -- make it pretty
    {"sainnhe/sonokai"},
}

return plugins

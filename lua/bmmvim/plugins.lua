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

    -- make it pretty
    {"sainnhe/sonokai"},
}

return plugins

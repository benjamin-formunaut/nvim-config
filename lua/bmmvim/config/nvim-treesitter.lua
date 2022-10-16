require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
    -- NOTE: This is an experimental feature
    indent = {
        enable = true,
    },
    yati = {
        enable = true,
    },
    ensure_installed = {
        -- back end
        "lua",
        "vim",
        "python",
        "sql",
        "dockerfile",
        "bash",
        "gitignore",
        "make",
        "markdown",
        "markdown_inline",
        "http",

        -- data & config
        "json",
        "yaml",
        "toml",

        -- front end
        "typescript",
        "javascript",
        "html",
        "css",
    },
}

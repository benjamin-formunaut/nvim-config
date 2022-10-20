local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

local options = {
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
    auto_install = true,
    ensure_installed = {
        -- back end
        "comment",
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

treesitter.setup(options)

local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then
    return
end

local options = {
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
    show_current_context = true,
    use_treesitter = true,
}

indent_blankline.setup(options)

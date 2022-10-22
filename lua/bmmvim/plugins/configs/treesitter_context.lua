local ok, treesitter_context = pcall(require, "treesitter-context")

if not ok then
    return
end

local options = {
    patterns = {
        default = {
            "class",
            "function",
            "method",
        }
    }
}

treesitter_context.setup(options)

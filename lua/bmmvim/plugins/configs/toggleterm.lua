local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
    return
end

vim.o.hidden = true

vim.cmd([[autocmd! TermOpen term://* lua require("bmmvim.utils").load_mappings("toggleterm", { buffer = 0 })]])

local options = {
    shade_terminals = false,
    open_mapping = [[<C-\>]],
}

toggleterm.setup(options)

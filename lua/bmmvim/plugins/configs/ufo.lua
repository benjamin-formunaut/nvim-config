local ok, ufo = pcall(require, "ufo")
if not ok then
    return
end

-- TODO: set this to "1" when this is merged
-- ref https://github.com/neovim/neovim/pull/17446
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

local options = {
    provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
    end,
}

ufo.setup(options)

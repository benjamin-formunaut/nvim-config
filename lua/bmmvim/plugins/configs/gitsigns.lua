local ok, gitsigns = pcall(require, "gitsigns")

if not ok then
    return
end

local utils = require("bmmvim.utils")

local options = {
    sign_priority = 6,
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "│" },
        topdelete = { text = "│" },
        changedelete = { text = "│" },
    },
    on_attach = function(bufnr)
        utils.load_mappings("gitsigns", { buffer = bufnr })
    end,
    preview_config = {
        -- options passed to nvim_open_win
        border = "none",
    },
}

gitsigns.setup(options)

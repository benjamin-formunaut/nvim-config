local ok, luasnip = pcall(require, "luasnip")

if not ok then
    return
end

local options = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
}

-- TODO: might not always make sense (only when django is installed)
luasnip.filetype_extend("python", { "django", "django-rest" })
luasnip.filetype_extend("htmldjango", { "djangohtml" })

luasnip.config.set_config(options)

require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
require("luasnip.loaders.from_vscode").lazy_load()

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        if
            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
        then
            require("luasnip").unlink_current()
        end
    end,
})

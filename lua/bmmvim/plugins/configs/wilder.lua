local ok, wilder = pcall(require, "wilder")
if not ok then
    return
end

local options = {
    modes = { ":", "/", "?" },
}

wilder.set_option(
    "renderer",
    -- see :h wilder#popupmenu_border_theme()
    wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        highlighter = wilder.basic_highlighter(),
        highlights = {
            border = "Normal",
        },
        border = "rounded",
    }))
)

wilder.setup(options)

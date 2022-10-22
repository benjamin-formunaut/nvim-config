local ok, bufferline = pcall(require, "bufferline")

if not ok then
    return
end

local options = {
    options = {
        -- disable close icon
        middle_mouse_command = "",
        show_buffer_close_icons = false,
        show_close_icon = false,

        -- display errors
        -- TODO: add styles and highlighting
        -- ref https://github.com/akinsho/bufferline.nvim#lsp-indicators
        diagnostics = "nvim_lsp",

        -- more prominent indicator
        indicator = {
            style = "underline",
        },

        offsets = {
            {
                filetype = "NvimTree",
                separator = true,
            },
        },

        -- TODO: custom areas
        -- ref https://github.com/akinsho/bufferline.nvim#custom-areas
    },
    highlights = {
        buffer_selected = {
            italic = false,
        },
    },
}

bufferline.setup(options)

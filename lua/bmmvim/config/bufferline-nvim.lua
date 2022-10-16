require("bufferline").setup {
    options = {
        -- disable the mouse
        right_mouse_command = '',
        middle_mouse_command = '',
        left_mouse_command = '',
        show_buffer_close_icons = false,

        -- display errors
        -- TODO: add styles and highlighting
        -- ref https://github.com/akinsho/bufferline.nvim#lsp-indicators
        diagnostics = "nvim_lsp",

        -- more prominent indicator
        indicator = {
            style = "underline",
        },

        -- TODO: sidebar offsets
        -- ref https://github.com/akinsho/bufferline.nvim#sidebar-offsets

        -- TODO: custom areas
        -- ref https://github.com/akinsho/bufferline.nvim#custom-areas
    },
    highlights = {
    buffer_selected = {
      italic = false
    },
  }
}

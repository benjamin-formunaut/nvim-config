vim.cmd([[

    if has('termguicolors')
        set termguicolors
    endif

    let g:sonokai_style = 'default'
    let g:sonokai_better_performance = 1
    let g:sonokai_current_word  = 'bold'

    colorscheme sonokai
]])

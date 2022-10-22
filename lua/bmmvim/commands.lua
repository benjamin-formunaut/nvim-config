local M = {}


local utils = require("bmmvim.utils")


function M.init()
    -- refresh config
    vim.api.nvim_create_user_command("Reload", utils.reload_config, { nargs = 0 })

    -- open git gutter changes
    vim.api.nvim_create_user_command("Gqf", "GitGutterQuickFix | copen", { nargs = 0 })
    vim.api.nvim_create_user_command("Gqfcf", "GitGutterQuickFixCurrentFile | copen", { nargs = 0 })

    -- ascii art text
    if utils.executable("figlet") then
        vim.api.nvim_create_user_command("Figlet", [[:r!figlet <args>]], { nargs = 1 })
    end

    -- enable toggle window zooming
    vim.cmd [[
    function! s:ZoomToggle() abort
      if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
      else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
      endif
    endfunction
    command! ZoomToggle call s:ZoomToggle()
    ]]
end

return M

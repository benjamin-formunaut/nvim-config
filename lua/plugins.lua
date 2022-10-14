local M = {}

-- put your plugins here
local plugins = {
    -- packer can manage itself
    {"wbthomason/packer.nvim"},
    {"qpkorr/vim-bufkill"},
}

function M.startup(use)
    for _, plugin in pairs(plugins) do
        use(plugin)
    end
end

return M

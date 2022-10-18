local M = {}

function M.init()
    require("bmmvim.plugins").init()
    require("bmmvim.options").init()
    require("bmmvim.keymaps").init()
    require("bmmvim.commands").init()
    require("bmmvim.autocommands").init()
end

return M

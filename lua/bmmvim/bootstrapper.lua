local M = {}

function M.init()
    require("bmmvim.options").init()
    require("bmmvim.utils").load_mappings("general")
    require("bmmvim.plugins").init()
    require("bmmvim.commands").init()
    require("bmmvim.autocommands").init()
end

return M

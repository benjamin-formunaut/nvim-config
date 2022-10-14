local M = {}

function M.init()
    local plugins = require("bmmvim.plugins")
    require("bmmvim.plugin_manager").init(plugins)
    require("bmmvim.options").init()
    require("bmmvim.keymaps").init()
    require("bmmvim.commands").init()
    require("bmmvim.autocommands").init()
end

return M

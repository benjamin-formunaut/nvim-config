local ok, toggletasks = pcall(require, "toggletasks")
if not ok then
    return
end

local options = {}

toggletasks.setup(options)

require("telescope").load_extension("toggletasks")

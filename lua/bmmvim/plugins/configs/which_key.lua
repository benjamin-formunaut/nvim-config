local ok, which_key = pcall(require, "which-key")
if not ok then
    return
end

local options = {
}

which_key.setup(options)

local mappings = require("bmmvim.keymaps").mappings

for opts, maps in pairs(mappings) do
    which_key.register(maps, opts)
end

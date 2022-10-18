local ok, which_key = pcall(require, "which-key")
if not ok then
    return
end

local options = {
}

which_key.setup(options)

local mappings = require("bmmvim.keymaps").mappings

for _, register_args in ipairs(mappings) do
    local opts, maps = unpack(register_args)
    which_key.register(maps, opts)
end

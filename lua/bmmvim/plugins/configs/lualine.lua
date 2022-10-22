local ok, lualine = pcall(require, "lualine")

if not ok then
    return
end

local options = {}

lualine.setup(options)

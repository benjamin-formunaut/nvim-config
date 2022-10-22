local ok, ts_autotag = pcall(require, "nvim-ts-autotag")

if not ok then
    return
end

local options = {}

ts_autotag.setup(options)

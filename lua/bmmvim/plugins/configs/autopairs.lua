local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then
    return
end

local options = {
    check_ts = true,
    fast_wrap = {},
}

npairs.setup(options)


local Rule = require('nvim-autopairs.rule')
local ts_conds = require('nvim-autopairs.ts-conds')

local rules = {
  Rule("f'", "'", "python")
    :with_pair(ts_conds.is_not_ts_node {"string", "comment"}),
}

npairs.add_rules(rules)

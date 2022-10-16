local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')
local ts_conds = require('nvim-autopairs.ts-conds')

npairs.setup {
    check_ts = true,
    fast_wrap = {},
}

npairs.add_rules {
  Rule("f'", "'", "python")
    :with_pair(ts_conds.is_not_ts_node {"string", "comment"}),
}

local icons = {
    subroutine = "羚",
    method = "",
    func = "",
    variables = "",
    constructor = "",
    field = "ﰠ",
    interface = "",
    type = "",
    packages = "",
    property = "ﰠ",
    implementation = "",
    default = "",
    augroup = "פּ",
    macro = "",
    enumerator = "",
    const = "",
    macros = "",
    map = "פּ",
    fields = "ﰠ",
    functions = "",
    enum = "",
    ["function"] = "",
    target = "",
    typedef = "",
    namespace = "",
    enummember = "",
    variable = "",
    modules = "",
    constant = "",
    struct = "",
    types = "",
    module = "",
    typeParameter = "",
    package = "",
    class = "ﴯ",
    member = "",
    var = "",
    union = "鬒",
}

vim.api.nvim_set_var("vista_echo_cursor", false)
vim.api.nvim_set_var("vista_stay_on_open", false)
vim.api.nvim_set_var("vista#renderer#enable_icon", true)
vim.api.nvim_set_var("vista#renderer#icons", icons)
vim.api.nvim_set_var("vista_fold_toggle_icons*", { "", "" })

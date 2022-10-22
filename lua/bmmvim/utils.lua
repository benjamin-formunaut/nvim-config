local M = {}

M.get_nvim_version = function()
    local actual_ver = vim.version()

    local nvim_ver_str = string.format("%d.%d.%d", actual_ver.major, actual_ver.minor, actual_ver.patch)
    return nvim_ver_str
end

M.executable = function(name)
    if vim.fn.executable(name) > 0 then
        return true
    end

    return false
end

M.load_mappings = function(section, mapping_opt)
    local mappings = require("bmmvim.mappings")[section]
    if mappings == nil then
        return false
    end

    mapping_opt = mapping_opt or {}

    for mode, mode_values in pairs(mappings) do
        for keybind, mapping_info in pairs(mode_values) do
            local opts = vim.tbl_deep_extend("force", mapping_opt, mapping_info.opts or {})
            opts.desc = mapping_info[2]

            vim.keymap.set(mode, keybind, mapping_info[1], opts)
        end
    end
    return true
end

local default_configure_plugin_opts = {
    load_module = true,
    load_keys = true,
}
M.configure_plugin = function(plugin_name, opts)
    opts = vim.tbl_extend("keep", opts or {}, default_configure_plugin_opts)

    if opts.load_module then
        local module_path = "bmmvim.plugins.configs." .. plugin_name
        local ok, require_error = pcall(require, module_path)
        if not ok then
            vim.notify(
                string.format("Unable to initialize plugin %s\n%s", plugin_name, require_error),
                vim.log.levels.WARN
            )
            return
        end
    end

    if opts.load_keys and not M.load_mappings(plugin_name) then
        vim.notify("Unable to load mappings for plugin " .. plugin_name, vim.log.levels.WARN)
    end
end

M.reload_config = function()
    for name, _ in pairs(package.loaded) do
        if name:match("^bmmvim") then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
end

return M

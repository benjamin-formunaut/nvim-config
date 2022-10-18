local M = {}

function M.get_nvim_version()
    local actual_ver = vim.version()

    local nvim_ver_str = string.format("%d.%d.%d", actual_ver.major, actual_ver.minor, actual_ver.patch)
    return nvim_ver_str
end

function M.executable(name)
    if vim.fn.executable(name) > 0 then
        return true
    end

    return false
end

function M.reload_config()
    for name, _ in pairs(package.loaded) do
        if name:match("^bmmvim") then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
end

return M

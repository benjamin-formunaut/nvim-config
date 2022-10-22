local ok, mason_lspconfig = pcall(require, "mason-lspconfig")

if not ok then
    return
end

local config = {
    automatic_installation = true,
}

mason_lspconfig.setup(config)

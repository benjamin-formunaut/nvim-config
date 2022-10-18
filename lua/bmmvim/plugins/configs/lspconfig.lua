local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    return
end

-- configure diagnostic
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
-- change diagnostic signs.
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for kind, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. kind
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
    -- highlight the current variable and its usages in the buffer.
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd([[
        hi! link LspReferenceRead Visual
        hi! link LspReferenceText Visual
        hi! link LspReferenceWrite Visual
        ]])

        local gid = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            group = gid,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd("CursorMoved", {
            group = gid,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

local lua_confg = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- make the server aware of neovim runtime files,
                -- ref https://github.com/sumneko/lua-language-server/wiki/Libraries#link-to-workspace
                library = vim.api.nvim_get_runtime_file("", true),
                maxPreload = 2000,
                preloadFileSize = 50000,
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                }
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

lspconfig.sumneko_lua.setup(lua_confg)

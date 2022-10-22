local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

local on_attach = function(client, bufnr)
    -- autoformat on save
    -- ref https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("lsp_format_sync", { clear = true }),
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = function()
                        return client.name == "null-ls"
                    end,
                })
            end,
        })
    end
end

local options = {
    on_attach = on_attach,
    sources = {
        -- general
        null_ls.builtins.formatting.prettier,
        -- lua
        null_ls.builtins.formatting.stylua,
    },
}

null_ls.setup(options)

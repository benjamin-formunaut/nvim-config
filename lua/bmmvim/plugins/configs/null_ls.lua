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
    -- ref https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    sources = {
        -- general
        null_ls.builtins.formatting.prettier,
        -- lua
        null_ls.builtins.formatting.stylua,
        -- python
        null_ls.builtins.diagnostics.flake8,
        --django
        null_ls.builtins.diagnostics.curlylint,
        -- null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        -- postgres sql
        null_ls.builtins.formatting.sqlfluff.with({
            extra_args = { "--dialect", "postgres" },
        }),
        -- dockerfile
        null_ls.builtins.diagnostics.hadolint,
        -- sh
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.formatting.beautysh,
        -- git
        null_ls.builtins.code_actions.gitrebase,
    },
}

null_ls.setup(options)

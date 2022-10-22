local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    return
end

------------------------------------------------------------------------
-- Diagnostic
------------------------------------------------------------------------

-- configure diagnostic
vim.diagnostic.config({
    virtual_text = false,
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

-- only show the most severe diagnostic sign
---custom namespace
local name_space = vim.api.nvim_create_namespace("severe-diagnostics")

---reference to the original handler
local orig_signs_handler = vim.diagnostic.handlers.signs

-- Override the built-in signs handler
vim.diagnostic.handlers.signs = {
    show = function(_, bufnr, _, opts)
        -- get all diagnostics from the buffer
        local diagnostics = vim.diagnostic.get(bufnr)

        -- Find the "worst" diagnostic per line
        local max_severity_per_line = {}
        for _, diagnostic in pairs(diagnostics) do
            local max = max_severity_per_line[diagnostic.lnum]
            if not max or diagnostic.severity < max.severity then
                max_severity_per_line[diagnostic.lnum] = diagnostic
            end
        end

        -- pass filtered diagnostics to original handler
        local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
        orig_signs_handler.show(name_space, bufnr, filtered_diagnostics, opts)
    end,
    hide = function(_, bufnr)
        orig_signs_handler.hide(name_space, bufnr)
    end,
}

------------------------------------------------------------------------
-- Lspconfig
------------------------------------------------------------------------

local on_attach = function(client, bufnr)
    -- diagnostics hover
    vim.api.nvim_create_autocmd("CursorHold", {
        group = vim.api.nvim_create_augroup("lsp_diagnosict_float", { clear = true }),
        buffer = bufnr,
        callback = function()
            vim.diagnostic.open_float({
                focusable = false,
            })
        end,
    })

    -- highlight the current variable and its usages in the buffer.
    if client.server_capabilities.documentHighlightProvider then
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

local language_options = {
    -- lua
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using
                    version = "LuaJIT",
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                    neededFileStatus = {
                        ["codestyle-check"] = "Any",
                    },
                },
                workspace = {
                    -- make the server aware of neovim runtime files,
                    -- ref https://github.com/sumneko/lua-language-server/wiki/Libraries#link-to-workspace
                    library = vim.api.nvim_get_runtime_file("", true),
                    maxPreload = 2000,
                    preloadFileSize = 50000,
                },
                format = {
                    enable = false,
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    -- python
    pyright = {},
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for server, options in pairs(language_options) do
    local merged_options = vim.tbl_extend("keep", options, {
        on_attach = on_attach,
        capabilities = capabilities,
    })
    lspconfig[server].setup(merged_options)
end

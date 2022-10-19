-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local M = {}

-- TODO: find a sane way to pass group names to which-key
-- ref https://github.com/folke/which-key.nvim#%EF%B8%8F-mappings
M.general = {
    n = {
        -- files
        ["<leader>fw"] = { ":w<CR>", "File Write" },
        ["<leader>fq"] = { ":q<CR>", "File Quit" },
        ["<leader>fc"] = { ":bd<CR>", "File Close" },
        ["<leader>fx"] = { ":qa!<CR>", "File Force quit all" },
        -- searching
        ["n"] = { "nzzzv", "Next search result" },
        ["N"] = { "Nzzzv", "Previous search result" },
        ["*"] = { "*zzzv", "Search word under cursor" },
        ["<Leader>/"] = { ":noh<cr>", "Clear search highlight" },
        -- split navigation
        ["<C-j>"] = { "<C-w>j", "Focus down split" },
        ["<C-k>"] = { "<C-w>k", "Focus up split" },
        ["<C-h>"] = { "<C-w>h", "Focus left split" },
        ["<C-l>"] = { "<C-w>l", "Focus right split" },
        -- buffer navigation
        ["]b"] = { ":bn<CR>", "Next buffer next" },
        ["[b"] = { ":bp<CR>", "Previous buffer" },
        -- quickfix list navigation
        ["]q"] = { ":cnext<CR>zzzv", "Next quickfix" },
        ["[q"] = { ":cprev<CR>zzzv", "Previous quickfix" },
        ["]Q"] = { ":cfirst<CR>zzzv", "First quickfix" },
        ["[Q"] = { ":clast<CR>zzzv", "Last quickfix" },
        -- TODO: replace with a toggle command
        ["<leader>qq"] = { ":copen<CR>", "Quickfix Open" },
        ["<leader>qc"] = { ":cclose<CR>", "Quickfix Close" },
        -- window
        ["<leader>wx"] = { ":<C-u>split<CR>", "Window Split" },
        ["<leader>wv"] = { ":<C-u>vsplit<CR>", "Window VSplit" },
        ["<leader>w="] = { "<C-w>=", "Window Equalize all" },
        ["<leader>wl"] = { "<C-w>|", "Window Max widht" },
        ["<leader>wk"] = { "<C-w>_", "Window Max height" },
        ["<leader>wz"] = { ":ZoomToggle<CR>", "Window Zoom toggle" },
        -- vim
        ["<leader>vr"] = { ":Reload<CR>", "Vim Reload" },
    },

    v = {
        -- maintain visual mode after horizontal move
        ["<"] = { "<gv", "Move left" },
        [">"] = { ">gv", "Move right" },
        -- vertical visual block move
        ["J"] = { ":m '>+1<CR>gv=gv", "Move up" },
        ["K"] = { ":m '<-2<CR>gv=gv", "Move Down" },
    },

    c = {
        -- emacs like cursor motions
        ["<C-a>"] = { "<Home>", "Go to start of line" },
        ["<C-e>"] = { "<End>", "Go to end of line" },
        ["<C-b>"] = { "<Left>", "Go one character backwar" },
        ["<C-f>"] = { "<Right>", "Go one character forward" },
        ["<A-b>"] = { "<C-Left>", "Go one word backward" },
        ["<A-f>"] = { "<C-Right>", "Go one word forward" },
        ["<C-d>"] = { "<Del>", "Delete one character forward" },
    },
}

M.lspconfig = {
    n = {
        -- diagnostic naviation
        ["]e"] = { ":lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
        ["[e"] = { ":lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic" },
        -- docs in floating window
        ["K"] = { ":lua vim.lsp.buf.hover()<CR>", "Docs" },
        -- code navigation
        ["<leader>cD"] = { ":lua vim.lsp.buf.declaration()<CR>", "Code Declaration" },
        ["<leader>cd"] = { ":lua vim.lsp.buf.definition()<CR>", "Code Definition" },
        ["<leader>ci"] = { ":lua vim.lsp.buf.implementation()<CR>", "Code Implementation" },
        ["<leader>cs"] = { ":lua vim.lsp.buf.signature_help()<CR>", "Code Signature help" },
        ["<leader>ct"] = { ":lua vim.lsp.buf.type_definition()<CR>", "Code Type deifinition" },
        ["<leader>cr"] = { ":lua vim.lsp.buf.rename()<CR>", "Code Rename" },
        ["<leader>ca"] = { ":lua vim.lsp.buf.code_action()<CR>", "Code Code action" },
        ["<leader>cu"] = { ":lua vim.lsp.buf.references()<CR>", "Code Usage" },
        ["<leader>ce"] = {
            -- TODO: autocmd from bmmvim.plugins.configs.lspconfig hijacks this
            function()
                vim.diagnostic.open_float({
                    scope = "buffer",
                    header = "File Diagnostics:",
                    focusable = false,
                    prefix = function(diagnostic, _, _)
                        return tostring(diagnostic.lnum) .. ": "
                    end,
                })
            end,
            "Code Diagnostic",
        },
        ["<leader>cq"] = { ":lua vim.diagnostic.setqflist()<CR>", "Code Set loclist" },
        ["<leader>cl"] = { ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
            "Code List workspace folders" },
    },
}

M.nvim_tree = {
    n = {
        ["<leader>ft"] = { ":NvimTreeToggle<CR>", "File Tree toggle" },
        ["<leader>fo"] = { ":NvimTreeFindFile<CR>", "File Tree current" },
    },
}

M.telescope = {
    n = {
        ["<leader>ss"] = { ":Telescope builtin<CR>", "Search Telescope" },
        ["<leader>sf"] = { ":Telescope find_files<CR>", "Search Files" },
        ["<leader>sa"] = { ":Telescope find_files follow=true no_ignore=true hidden=true<CR>", "Search All files" },
        ["<leader>sb"] = { ":Telescope buffers<CR>", "Search Buffers" },
        ["<leader>st"] = { ":Telescope tags<CR>", "Search Tags" },
        ["<leader>sh"] = { ":Telescope help_tags<CR>", "Search Help" },
        ["<leader>sw"] = { ":Telescope grep_string<CR>", "Search Word under cursor" },
        ["<leader>sc"] = { ":Telescope git_commits<CR>", "Search git commits" },
        ["<leader>sg"] = { ":Telescope git_status<CR>", "Search git status" },
        ["<leader>s/"] = { ":Telescope live_grep<CR>", "Search String" },
    },
}

M.fugitive = {
    n = {
        ["<leader>cg"] = { ":Git<CR>", "Git Status" },
        ["<leader>cb"] = { ":Git blame<CR>", "Git Blame" },
        ["<leader>cd"] = { ":Git diff<CR>", "Git Diff" },
        ["<leader>cl"] = { "Git log<CR>", "Git Log" },
        ["<leader>ch"] = { ":GBrowse!<CR>", "Git Hub link" },
    },

    v = {
        ["<leader>gh"] = { ":'<,'>GBrowse!<CR>", "Git Hub Link" },
    },
}

return M

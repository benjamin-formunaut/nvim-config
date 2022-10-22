-- Modes
--
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   operator_mode = "o",
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
        ["<leader>fx"] = { ":qa!<CR>", "File Force quit all" },
        -- buffer navigation
        ["]f"] = { ":bn<CR>", "Next buffer next" },
        ["[f"] = { ":bp<CR>", "Previous buffer" },
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
        -- quickfix list navigation
        ["]q"] = { ":cnext<CR>zzzv", "Next quickfix" },
        ["[q"] = { ":cprev<CR>zzzv", "Previous quickfix" },
        ["]Q"] = { ":cfirst<CR>zzzv", "First quickfix" },
        ["[Q"] = { ":clast<CR>zzzv", "Last quickfix" },
        -- TODO: replace with a toggle command
        ["<leader>qq"] = { ":copen<CR>", "Quickfix Open" },
        ["<leader>qc"] = { ":cclose<CR>", "Quickfix Close" },
        -- window
        ["<leader>vx"] = { ":<C-u>split<CR>", "Window Split" },
        ["<leader>vv"] = { ":<C-u>vsplit<CR>", "Window VSplit" },
        ["<leader>v="] = { "<C-w>=", "Window Equalize all" },
        ["<leader>vl"] = { "<C-w>|", "Window Max widht" },
        ["<leader>vk"] = { "<C-w>_", "Window Max height" },
        ["<leader>vz"] = { ":ZoomToggle<CR>", "Window Zoom toggle" },
        -- run things
        ["<leader>rr"] = { ":Reload<CR>", "Vim Reload" },
        ["<leader>rs"] = { ":PackerSync<CR>", "SyncPlugins" },
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
        ["]e"] = {
            function()
                vim.diagnostic.goto_next({ float = { focusable = false, source = true } })
            end,
            "Next diagnostic",
        },
        ["[e"] = {
            function()
                vim.diagnostic.goto_prev({ float = { focusable = false, source = true } })
            end,
            "Next diagnostic",
        },
        -- docs in floating window
        ["K"] = { ":lua vim.lsp.buf.hover()<CR>", "Docs" },
        -- code navigation
        ["<leader>nD"] = { ":lua vim.lsp.buf.declaration()<CR>", "Code Declaration" },
        ["<leader>nd"] = { ":lua vim.lsp.buf.definition()<CR>", "Code Definition" },
        ["<leader>ni"] = { ":lua vim.lsp.buf.implementation()<CR>", "Code Implementation" },
        ["<leader>ns"] = { ":lua vim.lsp.buf.signature_help()<CR>", "Code Signature help" },
        ["<leader>nt"] = { ":lua vim.lsp.buf.type_definition()<CR>", "Code Type deifinition" },
        ["<leader>nr"] = { ":lua vim.lsp.buf.rename()<CR>", "Code Rename" },
        ["<leader>na"] = { ":lua vim.lsp.buf.code_action()<CR>", "Code Code action" },
        ["<leader>nu"] = { ":lua vim.lsp.buf.references()<CR>", "Code Usage" },
        ["<leader>ne"] = {
            -- TODO: might be less useful than Telescope diagnosts
            function()
                vim.diagnostic.open_float({
                    source = true,
                    scope = "buffer",
                    header = "File Diagnostics:",
                    focusable = false,
                    prefix = function(diagnostic, _, _)
                        return tostring(diagnostic.lnum + 1) .. ": "
                    end,
                })
            end,
            "Code Diagnostic",
        },
        ["<leader>nq"] = { ":lua vim.diagnostic.setqflist()<CR>", "Code Set loclist" },
        ["<leader>nl"] = {
            ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
            "Code List workspace folders",
        },
    },
}

M.null_ls = M.lspconfig

M.nvim_tree = {
    n = {
        ["<leader>ft"] = { ":NvimTreeToggle<CR>", "File Tree toggle" },
        ["<leader>fo"] = { ":NvimTreeFindFile<CR>", "File Tree current" },
    },
}

M.telescope = {
    n = {
        ["<leader><leader><leader>"] = { ":Telescope builtin<CR>", "Search Telescope" },
        ["<leader><leader>f"] = { ":Telescope find_files<CR>", "Search Files" },
        ["<leader><leader>a"] = {
            ":Telescope find_files follow=true no_ignore=true hidden=true<CR>",
            "Search All files",
        },
        ["<leader><leader>b"] = { ":Telescope buffers<CR>", "Search Buffers" },
        ["<leader><leader>t"] = { ":Telescope tags<CR>", "Search Tags" },
        ["<leader><leader>r"] = { ":Telescope command_history<CR>", "Search Tags" },
        ["<leader><leader>e"] = { ":Telescope diagnostics bufnr=0<CR>", "Search Tags" },
        ["<leader><leader>h"] = { ":Telescope help_tags<CR>", "Search Help" },
        ["<leader><leader>w"] = { ":Telescope grep_string<CR>", "Search Word under cursor" },
        ["<leader><leader>c"] = { ":Telescope git_commits<CR>", "Search git commits" },
        ["<leader><leader>g"] = { ":Telescope git_status<CR>", "Search git status" },
        ["<leader><leader>/"] = { ":Telescope live_grep<CR>", "Search String" },
    },
    v = {
        ["<leader><leader>w"] = { [["zy:Telescope grep_string default_text=<C-r>z]], "Search selection" },
    },
}

M.fugitive = {
    n = {
        ["<leader>gg"] = { ":Git<CR>", "Git Status" },
        ["<leader>gb"] = { ":Git blame<CR>", "Git Blame" },
        ["<leader>gd"] = { ":Git diff<CR>", "Git Diff" },
        ["<leader>gl"] = { "Git log<CR>", "Git Log" },
    },
}

M.rhubarb = {
    n = {
        ["<leader>gh"] = { ":GBrowse!<CR>", "Git Hub link" },
    },

    v = {
        ["<leader>gh"] = { ":'<,'>GBrowse!<CR>", "Git Hub Link" },
    },
}

M.gitsigns = {
    n = {
        -- hunk navigation
        ["]g"] = {
            function()
                if vim.wo.diff then
                    return "]g"
                end
                vim.schedule(function()
                    require("gitsigns").next_hunk()
                end)
                return "<Ignore>"
            end,
            "Jump to next hunk",
            opts = { expr = true },
        },
        ["[g"] = {
            function()
                if vim.wo.diff then
                    return "[g"
                end
                vim.schedule(function()
                    require("gitsigns").prev_hunk()
                end)
                return "<Ignore>"
            end,
            "Jump to prev hunk",
            opts = { expr = true },
        },

        -- actions
        -- TODO: see if you want require("gitsigns").diffthis or a diff from another plugin
        ["<leader>hp"] = {
            function()
                require("gitsigns").preview_hunk()
            end,
            "Preview hunk",
        },
        ["<leader>hb"] = {
            function()
                package.loaded.gitsigns.blame_line()
            end,
            "Blame line",
        },
        ["<leader>ht"] = {
            function()
                require("gitsigns").toggle_deleted()
            end,
            "Toggle deleted",
        },
    },

    -- stage & unstage hunks on the fly
    [{ "n", "v" }] = {
        ["<leader>hs"] = { ":Gitsigns stage_hunk<CR>", "Stage hunk" },
        ["<leader>hr"] = { ":Gitsigns reset_hunk<CR>", "Reset hunk" },
    },

    -- hunk as text object
    [{ "o", "x" }] = {
        ["ih"] = { ":<C-U>Gitsigns select_hunk<CR>", "In hunk" },
        ["ah"] = { ":<C-U>Gitsigns select_hunk<CR>", "Around hunk" },
    },
}

M.bbye = {
    n = {
        ["<leader>fc"] = { ":Bdelete<CR>", "File Close" },
    },
}

return M

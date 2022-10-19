-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local M = {}


M.mappings = {
    [{}] = {
        -- searching
        n = { "nzzzv", "Next search result" },
        N = { "Nzzzv", "Previous search result" },
        ["*"] = { "*zzzv", "Search word under cursor" },
        -- split resizing
        -- TODO: replace with plugin
        ["<Up>"] = { ":resize -2<CR>", "" },
        ["<Down>"] = { ":resize +2<CR>", "" },
        ["<Left>"] = { ":vertical resize -2<CR>", "" },
        ["<Right>"] = { ":vertical resize +2<CR>", "" },
        -- split navigation
        ["<C-j>"] = { "<C-w>j", "Focus down split" },
        ["<C-k>"] = { "<C-w>k", "Focus up split" },
        ["<C-h>"] = { "<C-w>h", "Focus left split" },
        ["<C-l>"] = { "<C-w>l", "Focus right split" },
        -- buffer navigation
        ["]b"] = { ":bn<CR>", "Next buffer next" },
        ["[b"] = { ":bp<CR>", "Previous buffer" },
        -- hunk navigation
        -- ["]h"] = {"<Plug>(GitGutterNextHunk)", "Next hunk"},
        -- ["[h"] = {"<Plug>(GitGutterPrevHunk)", "Previous hunk"},
        -- quickfix list navigation
        ["]q"] = { ":cnext<CR>zzzv", "Next quickfix" },
        ["[q"] = { ":cprev<CR>zzzv", "Previous quickfix" },
        ["]Q"] = { ":cfirst<CR>zzzv", "First quickfix" },
        ["[Q"] = { ":clast<CR>zzzv", "Last quickfix" },
        -- diagnostic naviation
        ["]e"] = { ":lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
        ["[e"] = { ":lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic" },
        -- see docs
        K = { ":lua vim.lsp.buf.hover()<CR>", "Docs" }
    },
    [{ prefix = "<leader>" }] = {
        f = {
            name = "File",
            w = { ":w<CR>", "Write" },
            q = { ":q<CR>", "Quit" },
            x = { ":qa!<CR>", "Force quit all" },
            t = { ":NvimTreeToggle<CR>", "Tree toggle" },
            o = { ":NvimTreeFindFile<CR>", "Tree current" },
        },
        b = {
            name = "Buffer",
            c = { ":bd<CR>", "Close" },
        },
        w = {
            name = "Window",
            x = { ":<C-u>split<CR>", "Split" },
            v = { ":<C-u>vsplit<CR>", "VSplit" },
            ["="] = { "<C-w>=", "Equalize all" },
            l = { "<C-w>|", "Max widht" },
            k = { "<C-w>_", "Max height" },
        },
        s = {
            name = "Search",
            s = { ":Telescope builtin<CR>", "Telescope" },
            f = { ":Telescope find_files<CR>", "Files" },
            a = { ":Telescope find_files follow=true no_ignore=true hidden=true <CR>", "All files" },
            b = { ":Telescope buffers<CR>", "Buffers" },
            t = { ":Telescope tags<CR>", "Tags" },
            h = { ":Telescope help_tags<CR>", "Help" },
            w = { ":Telescope grep_string<CR>", "Word under curso" },
            c = { "<cmd> Telescope git_commits <CR>", "git commits" },
            g = { "<cmd> Telescope git_status <CR>", "git status" },
            ["/"] = { ":Telescope live_grep<CR>", "String" },
        },
        c = {
            name = "Code",
            D = { ":lua vim.lsp.buf.declaration()<CR>", "Declaration" },
            d = { ":lua vim.lsp.buf.definition()<CR>", "Definition" },
            i = { ":lua vim.lsp.buf.implementation()<CR>", "Implementation" },
            s = { ":lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
            t = { ":lua vim.lsp.buf.type_definition()<CR>", "Type deifinition" },
            r = { ":lua vim.lsp.buf.rename()<CR>", "Rename" },
            a = { ":lua vim.lsp.buf.code_action()<CR>", "Code action" },
            u = { ":lua vim.lsp.buf.references()<CR>", "Usage" },
            e = {
                -- TODO: autocmd from bmmvm.plugins.configs.lspconfig hijacks this
                function()
                    vim.diagnostic.open_float({
                        scope = "buffer",
                        header = "File Diagnostics:",
                        prefix = function(diagnostic, _, _)
                            return tostring(diagnostic.lnum) .. ": "
                        end,
                    })
                end,
                "Diagnostic",
            },
            q = { ":lua vim.diagnostic.setqflist()<CR>", "Set loclist" },
            l = { ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List workspace folders" },
        },
        -- g = {
        --     name = "Git",
        --     g = {":Git<CR>", "Status"},
        --     b = {":Git blame<CR>", "Blame"},
        --     d = {":Git diff<CR>", "Diff"},
        --     l = {"Git log<CR>", "Log"},
        --     h = {":GBrowse!<CR>", "Hub link"},
        -- },
        -- h = {
        --     name = "Hunk",
        --     l = {":Gqfcf<CR>", "In quickfix list"},
        --     L = {":Gqf<CR>", "In quickfix list"},
        --     p = {":GitGutterPreviewHunk<CR>", "Preview"},
        --     s = {":GitGutterStageHunk<CR>", "Stage"},
        --     u = {":GitGutterUndoHunk<CR>", "Undo"},
        -- },
        q = {
            name = "Quickfix list",
            q = { ":copen<CR>", "Open" },
            c = { ":cclose<CR>", "Close" },
        },
        v = {
            name = "Vim config",
            r = { ":Reload<CR>", "Reload" },
        },
    },
    [{ mode = "v" }] = {
        -- maintain visual mode after horizontal move
        ["<"] = { "<gv", "Move left" },
        [">"] = { ">gv", "Move right" },
        -- vertucal visual block move
        J = { ":m '>+1<CR>gv=gv", "Move up" },
        K = { ":m '<-2<CR>gv=gv", "Move Down" },
    },
    [{ mode = "v", prefix = "<leader>" }] = {
        -- g = {
        --     name = "Git",
        --     h = {":'<,'>GBrowse!<CR>", "Hub Link"},
        -- },
    },
}

local keymap = vim.keymap

function M.init()
    -- follow this Leader
    -- ref https://stackoverflow.com/questions/446269/can-i-use-space-as-mapLeader-in-vim
    keymap.set("n", "<Space>", "<Nop>")
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- TODO: find a way to map remaining via which-key
    keymap.set("n", "<Leader>/", ":noh<cr>")

    -- emacs like cursor motions
    keymap.set("c", "<C-a>", "<Home>")
    keymap.set("c", "<C-e>", "<End>")
    keymap.set("c", "<C-b>", "<Left>")
    keymap.set("c", "<C-f>", "<Right>")
    keymap.set("c", "<A-b>", "<C-Left>")
    keymap.set("c", "<A-f>", "<C-Right>")
    keymap.set("c", "<C-d>", "<Del>")
end

return M

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local M = {}

local wk = require("which-key")

local mappings = {
    {
        {},
        {
            -- searching
            n = {"nzzzv", "Next search result"},
            N = {"Nzzzv", "Previous search result"},
            ["*"] = {"*zzzv", "Search word under cursor"},
            -- split resizing
            -- TODO: replace with plugin
            ["<Up>"] = {":resize -2<CR>", ""},
            ["<Down>"] = {":resize +2<CR>", ""},
            ["<Left>"] = {":vertical resize -2<CR>", ""},
            ["<Right>"] = {":vertical resize +2<CR>", ""},
            -- split navigation
            ["<C-j>"] = {"<C-w>j", "Focus down split"},
            ["<C-k>"] = {"<C-w>k", "Focus up split"},
            ["<C-h>"] = {"<C-w>h", "Focus left split"},
            ["<C-l>"] = {"<C-w>l", "Focus right split"},
            ["<M-j>"] = {"<C-w>J", "Move split down"},
            ["<M-k>"] = {"<C-w>K", "Move split up"},
            ["<M-l>"] = {"<C-w>L", "Move split left"},
            ["<M-h>"] = {"<C-w>H", "Move split right"},
            -- buffer navigation
            ["]b"] = {":bn<CR>", "Next buffer next"},
            ["[b"] = {":bp<CR>", "Previous buffer"},
            -- hunk navigation
            -- ["]h"] = {"<Plug>(GitGutterNextHunk)", "Next hunk"},
            -- ["[h"] = {"<Plug>(GitGutterPrevHunk)", "Previous hunk"},
            -- quickfix list navigation
            ["]q"] = {":cnext<CR>zzzv", "Next quickfix"},
            ["[q"] = {":cprev<CR>zzzv", "Previous quickfix"},
            ["]Q"] = {":cfirst<CR>zzzv", "First quickfix"},
            ["[Q"] = {":clast<CR>zzzv", "Last quickfix"},
        },
    },
    {
        {prefix = "<leader>"},
        {
            f = {
                name = "File",
                w = {":w<CR>", "Write"},
                q = {":q<CR>", "Quit"},
                x = {":qa!<CR>", "Force quit all"},
            },
            b = {
                name = "Buffer",
                b = {":buffers", "List"},
                c = {":bd<CR>", "Close"},
            },
            w = {
                name = "Window",
                x = {":<C-u>split<CR>", "Split"},
                v = {":<C-u>vsplit<CR>", "VSplit"},
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
                q = {":copen<CR>", "Open"},
                c = {":cclose<CR>", "Close"},
            },
            v = {
                name = "Vim config",
                r = {":Reload<CR>", "Reload"},
            },
        },
    },
    {
        {mode = "v"},
        {
            -- maintain visual mode after horizontal move
            ["<"] = {"<gv", "Move left"},
            [">"] = {">gv", "Move right"},
            -- vertucal visual block move
            J = {":m '>+1<CR>gv=gv", "Move up"},
            K = {":m '<-2<CR>gv=gv", "Move Down"},
        },
    },
    {
        {mode = "v", prefix = "<leader>"},
        {
            -- g = {
            --     name = "Git",
            --     h = {":'<,'>GBrowse!<CR>", "Hub Link"},
            -- },
        },
    },
}

local keymap = vim.keymap

function M.init()
    -- follow this Leader
    -- ref https://stackoverflow.com/questions/446269/can-i-use-space-as-mapLeader-in-vim
    keymap.set("n", "<Space>", "<Nop>")
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    for _, register_args in ipairs(mappings) do
        opts, maps = unpack(register_args)
        wk.register(maps, opts)
    end

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

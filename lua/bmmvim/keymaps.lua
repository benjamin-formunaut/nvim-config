-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local M = {}

local keymap = vim.keymap

function M.init()
    -- follow this Leader
    -- ref https://stackoverflow.com/questions/446269/can-i-use-space-as-mapLeader-in-vim
    keymap.set("n", "<Space>", "<Nop>")
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- searching
    keymap.set("n", "n", "nzzzv")
    keymap.set("n", "N", "Nzzzv")
    keymap.set("n", "*", "*zzzv")
    keymap.set("n", "<Leader>/", ":noh<cr>")

    -- file navigation <Leader>f
    keymap.set("n", "<Leader>fw", ":w<CR>")
    keymap.set("n", "<Leader>fq", ":q<CR>")
    keymap.set("n", "<Leader>fx", ":qa!<CR>")
    -- keymap.set("n", "<Leader>ft", ":NERDTreeToggle<CR>")
    -- keymap.set("n", "<Leader>fo", ":NERDTreeFind<CR>")

    -- find files
    -- keymap.set("n", "<Leader>ff", ":Files<CR>")
    -- keymap.set("n", "<Leader>fg", ":GFiles<CR>")
    -- keymap.set("n", "<Leader>fc", ":GFiles?<CR>")
    -- keymap.set("n", "<Leader>fh", ":History<CR>")

    -- serach <Leader>s
    -- keymap.set("n", "<Leader>ss", "<Plug>RgRawSearch ''<CR>")
    -- keymap.set("n", "<Leader>sr", "<Plug>RgRawSearch")
    -- keymap.set("n", "<Leader>sw", "<Plug>RgRawWordUnderCursor<CR>")
    -- keymap.set("v", "<Leader>sw", "<Plug>RgRawVisualSelection<CR>")
    -- keymap.set("n", "<Leader>st", ":Tags<CR>")
    -- keymap.set("n", "<Leader>sf", ":BLines<CR>")
    -- keymap.set("n", "<Leader>sb", ":Lines<CR>")

    -- buffer navigation <Leader>b
    keymap.set("n", "]b", ":bn<CR>")
    keymap.set("n", "[b", ":bp<CR>")
    -- keymap.set("n", "<Leader>bb", ":Buffer<CR>")
    -- keymap.set("n", "<Leader>bc", ":BD<CR>")

    -- split navigation
    keymap.set("n", "<Leader>x", ":<C-u>split<CR>")
    keymap.set("n", "<Leader>v", ":<C-u>vsplit<CR>")
    keymap.set("n", "<C-j>", "<C-w>j")
    keymap.set("n", "<C-k>", "<C-w>k")
    keymap.set("n", "<C-l>", "<C-w>l")
    keymap.set("n", "<C-h>", "<C-w>h")
    keymap.set("n", "<M-j>", "<C-w>J")
    keymap.set("n", "<M-k>", "<C-w>K")
    keymap.set("n", "<M-l>", "<C-w>L")
    keymap.set("n", "<M-h>", "<C-w>H")
    keymap.set("n", "<M-h>", "<C-w>H")
    -- TODO: replace with plugin
    keymap.set("n", "<Down>", ":resize +2<CR>")
    keymap.set("n", "<Up>", ":resize -2<CR>")
    keymap.set("n", "<Left>", ":vertical resize -2<CR>")
    keymap.set("n", "<Right>", ":vertical resize +2<CR>")

    -- git <Leader>g
    -- keymap.set("n", "<Leader>gg", ":Git<CR>")
    -- keymap.set("n", "<Leader>gb", ":Git blame<CR>")
    -- keymap.set("n", "<Leader>gd", ":Git diff<CR>")
    -- keymap.set("n", "<Leader>gl", "Git log<CR>")
    -- keymap.set("n", "<Leader>gh", ":GBrowse!<CR>")
    -- keymap.set("v", "<Leader>gh", ":'<,'>GBrowse!<CR>")

    -- TODO: find a mapping for git commit searches
    -- keymap.set("n", "<Leader>gg", ":Commits<CR>")
    -- keymap.set("n", "<Leader>gh", ":BCommits<CR>")

    -- hunks <Leader>g
    -- keymap.set("n", "]h", "<Plug>(GitGutterNextHunk)")
    -- keymap.set("n", "[h", "<Plug>(GitGutterPrevHunk)")
    -- keymap.set("n", "<Leader>hl", ":Gqfcf<CR>")
    -- keymap.set("n", "<Leader>hL", ":Gqf<CR>")
    -- keymap.set("n", "<Leader>hp", ":GitGutterPreviewHunk<CR>")
    -- keymap.set("n", "<Leader>hs", ":GitGutterStageHunk<CR>")
    -- keymap.set("n", "<Leader>hu", ":GitGutterUndoHunk<CR>")

    -- code navigation <Leader>c
    -- keymap.set("n", "<Leader>ct", ":TagbarToggle<CR>")

    -- quickfix list <Leader>q
    keymap.set("n", "]q", ":cnext<CR>zzzv")
    keymap.set("n", "[q", ":cprev<CR>zzzv")
    keymap.set("n", "]Q", ":cfirst<CR>zzzv")
    keymap.set("n", "[Q", ":clast<CR>zzzv")
    keymap.set("n", "<Leader>qq", ":copen<CR>")
    keymap.set("n", "<Leader>qc", ":cclose<CR>")

    -- vim config <Leader>v ?
    -- keymap.set("n", "<Leader>vv", ":Commands<CR>")
    -- keymap.set("n", "<Leader>vm", ":Maps<CR>")
    -- keymap.set("n", "<Leader>vh", ":Helptags<CR>")
    -- command Refresh source ~/.config/nvim/init.vim
    keymap.set("n", "<Leader>vr", ":Refresh<CR>")
    -- keymap.set("n", "<Leader>vi", ":PlugInstall<CR>")
    -- keymap.set("n", "<Leader>vi", ":PlugInstall<CR>")
    -- keymap.set("n", "<Leader>vu", ":PlugUpdate<CR>")
    -- keymap.set("n", "<Leader>vc", ":PlugClean<CR>")

    -- " Maintain visual mode after shifting
    keymap.set("v", "<", "<gv")
    keymap.set("v", ">", ">gv")

    -- move visual block
    keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    keymap.set("v", "K", ":m '<-2<CR>gv=gv")

    -- command line
    keymap.set("c", "<C-a>", "<Home>")
    keymap.set("c", "<C-e>", "<End>")
    keymap.set("c", "<C-b>", "<Left>")
    keymap.set("c", "<C-f>", "<Right>")
    keymap.set("c", "<A-b>", "<C-Left>")
    keymap.set("c", "<A-f>", "<C-Right>")
    keymap.set("c", "<C-d>", "<Del>")
end

return M

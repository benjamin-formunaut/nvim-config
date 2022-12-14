local M = {}

local options = {
    -- don't create backup files
    backup = false,
    -- creates a swapfile
    swapfile = false,
    -- the encoding written to a file
    fileencoding = "utf-8",
    -- if a file is being edited by another program it is not allowed to be edited
    writebackup = false,
    -- enable persistent undo
    undofile = true,
    -- reload file changes from disk
    autoread = true,
    -- respect file specific vim settings
    modeline = true,
    modelines = 10,

    -- allows neovim to access the system clipboard
    clipboard = "unnamedplus",
    -- no preselect for autocompletion
    completeopt = { "menu", "menuone", "noselect" },
    -- so that `` is visible in markdown files
    conceallevel = 0,

    -- convert tabs to spaces
    expandtab = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    autoindent = true,
    smartindent = true,

    -- special display whitespace
    list = true,
    listchars = "tab:ﲒ% ,eol:↲,nbsp:␣,trail:•,extends:,precedes:",

    -- time to wait for a mapped sequence to complete (in milliseconds)
    timeoutlen = 400,
    -- faster completion (4000ms default)
    updatetime = 300,

    -- highlight the current line
    cursorline = true,
    -- vertical bar
    colorcolumn = "+1",
    -- show linenumbers
    number = true,
    relativenumber = true,
    -- always show the sign column
    signcolumn = "yes:2",
    -- split directions
    splitbelow = true,
    splitright = true,
    -- more useful searching
    hlsearch = true,
    incsearch = true,
    ignorecase = true,
    smartcase = true,
    -- scroll offset
    scrolloff = 3,
    sidescrolloff = 3,
    -- handling long lines
    wrap = true,
    linebreak = false,
    -- pop up menu height
    pumheight = 10,
    -- hide -- INSERT --
    showmode = false,
}

function M.init()
    -- follow this Leader
    -- ref https://stackoverflow.com/questions/446269/can-i-use-space-as-mapLeader-in-vim
    vim.keymap.set("n", "<Space>", "<Nop>")
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- hide "match xx of xx" and other messages during auto-completion
    vim.opt.shortmess:append("c")

    -- don't auto wrap when hitting tw
    vim.opt.formatoptions:remove({ "t", "c" })

    for k, v in pairs(options) do
        vim.opt[k] = v
    end
end

return M

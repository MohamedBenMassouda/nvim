local opt = vim.opt
-- Line Numbers
opt.relativenumber = true
opt.nu = true
opt.scrolloff = 8

-- Tabs & Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- For dart files set tabstop and shiftwidth to 2
vim.cmd('autocmd BufNewFile,BufRead *.dart setlocal tabstop=2 shiftwidth=2')

-- Line Wrapping
opt.wrap = false

vim.opt.termguicolors = true

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

opt.incsearch = true

opt.colorcolumn = "80"

-- Cursor line
opt.cursorline = true -- BackSpace opt.backspace = "indent,eol,start" -- Clipboard opt.clipboard:append("unnamedplus")
-- Split Windows
opt.splitright = true
opt.splitbelow = true

-- opt.iskeyword:append("-")
-- UndoTree
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

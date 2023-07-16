local opt = vim.opt

-- Line Numbers
-- opt.relativenumber = true
opt.nu = true

-- Tabs & Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
vim.cmd('autocmd BufNewFile,BufRead *.dart setlocal tabstop=2 shiftwidth=2')

-- Line Wrapping
opt.wrap = false

vim.opt.termguicolors = true

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor line
opt.cursorline = true

-- BackSpace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")
vim.api.nvim_set_option("clipboard", "unnamedplus")

-- Split Windows
opt.splitright = true
opt.splitbelow = true

-- opt.iskeyword:append("-")
-- UndoTree
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

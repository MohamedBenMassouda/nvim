local opt = vim.opt

-- Line Numbers
opt.relativenumber = true
opt.nu = true
opt.scrolloff = 8

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line Wrapping
opt.wrap = false

opt.termguicolors = true

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

opt.hlsearch = true
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

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch" })
	end,
})

-- vim.cmd "autocmd BufNewFile,BufRead *.dart setlocal tabstop=2 shiftwidth=2"
-- vim.cmd "autocmd BufNewFile,BufRead *.tsx setlocal tabstop=2 shiftwidth=2"
-- vim.cmd "autocmd BufNewFile,BufRead *.ts setlocal tabstop=2 shiftwidth=2"
-- vim.cmd "autocmd BufNewFile,BufRead *.json setlocal tabstop=2 shiftwidth=2"
-- vim.cmd "autocmd BufNewFile,BufRead *.js setlocal tabstop=2 shiftwidth=2"
-- vim.cmd "autocmd BufNewFile,BufRead *.css setlocal tabstop=2 shiftwidth=2"
-- vim.cmd "autocmd BufNewFile,BufRead *.c setlocal tabstop=2 shiftwidth=2"
-- vim.cmd "autocmd BufNewFile,BufRead *.h setlocal tabstop=2 shiftwidth=2"

vim.filetype.add({
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang", [".*/rofi/.*%.rasi"] = "rasi" },
})

vim.g.copilot_assume_mapped = true

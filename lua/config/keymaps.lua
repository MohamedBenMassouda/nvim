local keymap = vim.keymap

keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>y", '"+y', { desc = "Copy to Clipboard" })
keymap.set("v", "<leader>y", '"+y', { desc = "Copy to Clipboard" })

-- Fzf
keymap.set("n", "<leader>ff", "<CMD>lua require('fzf-lua').files()<CR>", { desc = "Open Fzf Files" })
-- Remove when if you want to use telescope
keymap.set("n", "<leader>k", "<CMD>FzfLua keymaps<CR>", { desc = "Keymaps With FzfLua" })
keymap.set("n", "<leader>fwa", "<CMD>FzfLua grep_cWORD<CR>", { desc = "Find Word Current Word" })
-- keymap.set("n", "<leader>fwc", "<CMD>FzfLua grep_curbuf<CR>", { desc = "Find Word in Current Buffer with FzfLua" })
keymap.set("n", "<leader>fs", "<CMD>FzfLua live_grep_native<CR>", { desc = "Find Word in Current Buffer with FzfLua" })
keymap.set("n", "<leader>fC", "<CMD>FzfLua commands<CR>", { desc = "Find Commands" })
keymap.set("n", "<leader>fd", "<CMD>FzfLua diagnostics<CR>", { desc = "Find Diagnostics" })
keymap.set("n", "<leader>fr", "<CMD>FzfLua resume<CR>", { desc = "Resume Last FzfLua action" })
keymap.set("n", "<leader>fc", "<CMD>FzfLua colorschemes<CR>", { desc = "Colorschemes" })
keymap.set("n", "<leader>fg", "<CMD>lua require('fzf-lua').grep()<CR>", { desc = "Ripgrep" })
-- keymap.set("n", "<leader>ft", require("utils.flutter").flutter_commands, { desc = "Flutter Commands" })

keymap.set("n", "<C-s>", function()
  vim.cmd("w")
end, { desc = "Save File" })
keymap.set("n", "<C-q>", "<CMD>q<CR>", { desc = "Quit" })

keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split Window Vertically" }) -- Split Window Vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split Window Horizontally" }) -- Split Window Horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make Split Windows Even" }) -- Make Split windows split evenly
keymap.set("n", "<leader>sx", "<CMD>close<CR>", { desc = "Close Current Split Window" }) -- Close Current Split Window

-- Telescope Keymaps
-- local builtin = require "telescope.builtin"
-- vim.keymap.set("n", "<leader>ff", builtin.fd, { desc = "Find Files" })
-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
-- vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
-- keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
-- keymap.set("n", "<leader>cd", builtin.lsp_document_symbols, { desc = "LSP Document Symbols" })
-- keymap.set("n", "<leader>k", "<CMD>Telescope keymaps<CR>", { desc = "Keymaps With Telescope" })
-- keymap.set("n", "<leader>fwa", "<CMD>Telescope grep_string<CR>", { desc = "Find Word Current Word" })
keymap.set("n", "<leader>fwc", "<CMD>FzfLua blines<CR>", { desc = "Find Word in Current Buffer" })

keymap.set("n", "<leader>sr", ":%s/", { desc = "Search and Replace In all the File" })

-- Debugging

vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

-- Git
local git = require("gitsigns")

keymap.set("n", "<leader>gs", git.stage_hunk, { desc = "Stage Hunk" })
keymap.set("n", "<leader>gu", git.undo_stage_hunk, { desc = "Undo Stage Hunk" })
keymap.set("n", "<leader>gr", git.reset_hunk, { desc = "Reset Hunk" })
keymap.set("n", "<leader>gR", git.reset_buffer, { desc = "Reset Buffer" })
keymap.set("n", "<leader>gp", git.preview_hunk, { desc = "Preview Hunk" })
keymap.set("n", "<leader>gd", git.diffthis, { desc = "Difference" })
keymap.set("n", "<leader>gS", git.stage_buffer, { desc = "Stage Buffer" })
keymap.set("n", "<leader>gU", git.reset_buffer_index, { desc = "Reset Buffer Index" })

-- Formatting keymaps live in the conform.nvim spec so they lazy-load with it

-- keymap.set("n", "<leader>md", "<CMD>lua MiniFiles.open()<CR>", { desc = "Open Files Explorer" })

-- Noice
-- vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
-- 	if not require("noice.lsp").scroll(4) then
-- 		return "<c-f>"
-- 	end
-- end, { desc = "Scroll Down Lsp Documentation", silent = true, expr = true })
--
-- vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
-- 	if not require("noice.lsp").scroll(-4) then
-- 		return "<c-b>"
-- 	end
-- end, { desc = "Scroll Up Lsp Documentation", silent = true, expr = true })

-- Toggle bool values

vim.keymap.set("n", "<leader>ub", function()
  local line = vim.api.nvim_get_current_line()

  if line:match("true") then
    local new_line = line:gsub("true", "false")
    vim.api.nvim_set_current_line(new_line)
  end

  if line:match("false") then
    local new_line = line:gsub("false", "true")
    vim.api.nvim_set_current_line(new_line)
  end
end, { desc = "Toggle Boolean Values" })

-- Really awesome command for searching and replacing in the whole file
-- %s/\v(\w+)\[\]/ArrayList<\1>
-- %s used to search in the whole file
-- \v is used to use very magic
-- (\w+) is used to capture the word
-- \[\] is used to capture the brackets
-- ArrayList<\1> is used to replace the word with ArrayList<word>
-- \1 is used to use the first capture group

-- Noice
-- vim.keymap.set("n", "<leader>nd", "<CMD>Noice dismiss<CR>", { desc = "Open Noice Dismiss" })

-- Personal
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>fy",
-- 	require("monarch.utils.yank").yank_history_telescope,
-- 	{ noremap = true, silent = true, desc = "Yank history" }
-- )

vim.keymap.set("n", "<leader>fy", function()
  require("neoclip.fzf")()
end, { noremap = true, silent = true, desc = "Yank history" })

vim.keymap.set("n", "<ESC>", "<CMD>noh<CR>", { desc = "Clear Search Highlighting" })

vim.keymap.set("n", "-", "<CMD>Oil<CR>")

vim.keymap.set("n", "<leader>nd", function()
  Snacks.notifier.hide()
end, { desc = "Dismiss all notifications" })
vim.keymap.set("n", "<leader>nh", function()
  Snacks.notifier.show_history()
end, { desc = "Notification history" })
vim.keymap.set({ "n", "t" }, "<c-/>", function()
  Snacks.terminal.toggle()
end, { desc = "Toggle terminal" })

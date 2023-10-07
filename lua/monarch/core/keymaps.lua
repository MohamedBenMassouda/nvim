vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("v", "J", ":m '>+1<CR>gv=gv'", { desc = "No Highlight" })

keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Vim Explorer" })
keymap.set("n", "<C-s>", function()
    vim.cmd("w")
end, { desc = "Save File" })
keymap.set("n", "<C-q>", "<CMD>q<CR>", { desc = "Quit" })

keymap.set("n", "x", '"_x"')
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment current number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement current number" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split Window Vertically" })            -- Split Window Vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split Window Horizontally" })          -- Split Window Horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make Split Windows Even" })            -- Make Split windows split evenly
keymap.set("n", "<leader>sx", "<CMD>close<CR>", { desc = "Close Current Split Window" }) -- Close Current Split Window

keymap.set("n", "<leader>to", "<CMD>tabnew<CR>", { desc = "Open New Tab" })              -- Open New Tab
keymap.set("n", "<leader>tx", "<CMD>tabclose<CR>", { desc = "Close Current Tab" })       -- Close Current Tab
keymap.set("n", "<leader>tn", "<CMD>tabn<CR>")                                           -- Go to Tab Next
keymap.set("n", "<leader>tp", "<CMD>tabp<CR>")                                           -- Go to Tab Previous

keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>")

-- Telescope Keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help" })
keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
keymap.set("n", "<leader>cd", builtin.lsp_document_symbols, { desc = "LSP Document Symbols" })
keymap.set("n", "<leader>k", "<CMD>Telescope keymaps<CR>", { desc = "Keymaps With Telescope" })
keymap.set("n", "<leader>fwa", "<CMD>Telescope grep_string<CR>", { desc = "Find Word Current Word" })
keymap.set(
    "n",
    "<leader>fwc",
    "<CMD>Telescope current_buffer_fuzzy_find<CR>",
    { desc = "Find Word in Current Buffer with Telescope" }
)
keymap.set("n", "<leader>ft", "<CMD>Telescope flutter commands<CR>", { desc = "Open Flutter Tools Commands" })
keymap.set("n", "<leader>fc", "<CMD>Telescope commands<CR>", { desc = "Find Commands" })
keymap.set("n", "<leader>fd", "<CMD>Telescope diagnostics<CR>", { desc = "Find Diagnostics" })
keymap.set("n", "<leader>tr", "<CMD>Telescope resume<CR>", { desc = "Resume Last Telescope action" })

-- UndoTree Keymaps
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "UndoTreeToggle" })

keymap.set("n", "<leader>l", "<CMD>Lazy<CR>", { desc = "Open Lazy" })

keymap.set("n", "<leader>sr", ":%s/", { desc = "Search and Replace In all the File" })

-- Git Blame Messages Keymaps
keymap.set("n", "<leader>gm", "<CMD>GitMessenger<CR>", { desc = "Git Blame in Floating Window" })

-- Trouble
-- Lua
vim.keymap.set("n", "<leader>xx", function()
    require("trouble").open()
end, { desc = "Open Trouble" })
vim.keymap.set("n", "<leader>xw", function()
    require("trouble").open("workspace_diagnostics")
end, { desc = "Open Trouble Workspace Diagnostics" })
vim.keymap.set("n", "<leader>xd", function()
    require("trouble").open("document_diagnostics")
end, { desc = "Open Trouble Document Diagnostics" })
vim.keymap.set("n", "<leader>xl", function()
    require("trouble").open("quickfix")
end, { desc = "Open Trouble Quickfix" })
vim.keymap.set("n", "<leader>xq", function()
    require("trouble").open("loclist")
end, { desc = "Open Trouble Loclist" })

-- Debugging
vim.keymap.set("n", "<leader>b", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", "<CMD>lua require'dap'.continue()<CR>", { desc = "Continue" })

vim.keymap.set("n", "<C-=", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])    -- make the window smaller vertically
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]])  -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]])  -- make the window smaller horizontally by pressing shift and -

-- Git
local git = require("gitsigns")

keymap.set("n", "<leader>gs", git.stage_hunk, { desc = "Stage Hunk" })
keymap.set("n", "<leader>gu", git.undo_stage_hunk, { desc = "Undo Stage Hunk" })
keymap.set("n", "<leader>gr", git.reset_hunk, { desc = "Reset Hunk" })
keymap.set("n", "<leader>gR", git.reset_buffer, { desc = "Reset Buffer" })
keymap.set("n", "<leader>gp", git.preview_hunk, { desc = "Preview Hunk" })
keymap.set("n", "<leader>gd", git.diffthis, { desc = "Difference" })
keymap.set("n", "<leader>gb", git.blame_line, { desc = "Blame Line" })
keymap.set("n", "<leader>gS", git.stage_buffer, { desc = "Stage Buffer" })
keymap.set("n", "<leader>gU", git.reset_buffer_index, { desc = "Reset Buffer Index" })

-- Glance
vim.keymap.set("n", "gD", "<CMD>Glance definitions<CR>")
vim.keymap.set("n", "gR", "<CMD>Glance references<CR>")
vim.keymap.set("n", "gY", "<CMD>Glance type_definitions<CR>")
vim.keymap.set("n", "gM", "<CMD>Glance implementations<CR>")

-- Formatting
vim.keymap.set("n", "<Leader>cf", function()
    -- vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
    require("conform").format({ async = true, lsp_fallback = true })
end, { buffer = bufnr, desc = "[lsp] format" })

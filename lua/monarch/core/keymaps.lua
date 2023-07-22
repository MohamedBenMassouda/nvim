vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Vim Explorer" })
keymap.set("n", "<C-s>", "<CMD>w<CR>", { desc = "Save File" })
keymap.set("n", "<C-q>", "<CMD>q<CR>", { desc = "Quit" })

keymap.set("n", "x", '"_x"')
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment current number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement current number" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split Window Vertically" })            -- Split Window Vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split Window Horizontally" })          -- Split Window Horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make Split Windows Even" })            -- Make Split windows split evenly
keymap.set("n", "<leader>sx", "<CMD>close<CR>", { desc = "Close Current Split Window" }) -- Close Current Split Window


keymap.set("n", "<leader>to", "<CMD>tabnew<CR>", { desc = "Open New Tab" })        -- Open New Tab
keymap.set("n", "<leader>tx", "<CMD>tabclose<CR>", { desc = "Close Current Tab" }) -- Close Current Tab
keymap.set("n", "<leader>tn", "<CMD>tabn<CR>")                                     -- Go to Tab Next
keymap.set("n", "<leader>tp", "<CMD>tabp<CR>")                                     -- Go to Tab Previous

keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>")

-- Telescope Keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help" })
keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })

-- UndoTree Keymaps
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "UndoTreeToggle" })
keymap.set("n", "<leader>k", "<CMD>Telescope keymaps<CR>", { desc = "Keymaps With Telescope" })
keymap.set("n", "<leader>fwa", "<CMD>Telescope grep_string<CR>", { desc = "Find Word Current Word" })
keymap.set("n", "<leader>fwc", "<CMD>Telescope current_buffer_fuzzy_find<CR>",
    { desc = "Find Word in Current Buffer with Telescope" })
keymap.set("n", "<leader>ft", "<CMD>Telescope flutter commands<CR>", { desc = "Open Flutter Tools Commands" })
keymap.set("n", "<leader>fc", "<CMD>Telescope commands<CR>", { desc = "Find Commands" })
keymap.set("n", "<leader>fd", "<CMD>Telescope diagnostics<CR>", { desc = "Find Diagnostics" })
keymap.set("n", "<leader>tr", "<CMD>Telescope resume<CR>", { desc = "Resume Last Telescope action" })

keymap.set("n", "<leader>l", "<CMD>Lazy<CR>", { desc = "Open Lazy" })

keymap.set("n", "<leader>sr", ":%s/", { desc = "Search and Replace In all the File" })

-- Git Blame Messages Keymaps
keymap.set("n", "<leader>g", "<CMD>GitMessenger<CR>", { desc = "Git Blame in Floating Window" })

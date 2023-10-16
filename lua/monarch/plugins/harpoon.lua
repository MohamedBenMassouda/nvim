local marks = require "harpoon.mark"
local ui = require "harpoon.ui"

vim.keymap.set("n", "<leader>hu", ui.toggle_quick_menu, { noremap = true, silent = true, desc = "Harpoon Menu" })
vim.keymap.set("n", "<leader>hm", marks.add_file, { noremap = true, silent = true, desc = "Harpoon Mark" })
vim.keymap.set(
	"n",
	"<leader>h&",
	function() ui.nav_file(1) end,
	{ noremap = true, silent = true, desc = "Navigate to File 1" }
)
vim.keymap.set(
	"n",
	"<leader>hé",
	function() ui.nav_file(2) end,
	{ noremap = true, silent = true, desc = "Navigate to File 2" }
)
vim.keymap.set(
	"n",
	'<leader>h"',
	function() ui.nav_file(3) end,
	{ noremap = true, silent = true, desc = "Navigate to File 3" }
)
vim.keymap.set(
	"n",
	"<leader>h'",
	function() ui.nav_file(4) end,
	{ noremap = true, silent = true, desc = "Navigate to File 4" }
)

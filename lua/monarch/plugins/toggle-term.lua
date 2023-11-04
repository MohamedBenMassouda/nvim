local status, toggleterm = pcall(require, "toggleterm")

if not status then return end

toggleterm.setup {
	direction = "horizontal",
	size = 15,
	open_mapping = [[ <M-j> ]],
	hide_numbers = true,
	shade_files = {},
	shade_terminal = true,
	shading_factor = 2,
	start_in_insert = true,
	persist_size = true,
	close_on_exit = true,
	shell = vim.o.shell,
}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new { cmd = "lazygit", hidden = true }

function _lazygit_toggle() lazygit:toggle() end

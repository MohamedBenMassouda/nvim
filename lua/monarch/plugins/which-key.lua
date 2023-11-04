local wk = require "which-key"

wk.register({
	f = {
		name = "Telescope", -- optional group name
	},
	s = {
		name = "Splits",
	},
	t = {
		name = "Tabs",
	},
	fw = {
		name = "Find Word",
	},
	h = {
		name = "Harpoon",
	},
	d = {
		name = "DAP",
	},
}, { prefix = "<leader>" })

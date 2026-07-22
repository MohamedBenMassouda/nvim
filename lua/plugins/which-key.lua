return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		{ "<leader>q", group = "Session" },
		{ "<leader>r", group = "Rename/Refactor" },
	},
}

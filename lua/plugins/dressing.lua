return {
	{
		"stevearc/dressing.nvim",
		opts = {},
		config = function()
			require("dressing").setup({
				select = {
					backend = { "fzf_lua", "telescope", "fzf", "builtin", "nui" },
				},
				fzf_lua = {
					window = {
						width = 0.5,
						height = 0.5,
					},
				},
			})
		end,
	},
}

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = { "ibhagwan/fzf-lua" },
		config = function()
			require("neoclip").setup()
		end,
	},
}

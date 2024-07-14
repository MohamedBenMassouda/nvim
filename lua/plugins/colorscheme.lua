return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				styles = {
					comments = { "italic" },
					variables = { "italic" },
				},
				integrations = {
					noice = true,
					fidget = true,
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
					mini = false,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
					mason = true,
					which_key = true,
					dap = { enabled = true, enable_ui = true },
				},
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},
}

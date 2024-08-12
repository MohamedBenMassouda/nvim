return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		config = function()
			require("luasnip/loaders/from_vscode").load()

			require("luasnip").filetype_extend("javascript", { "javascriptreact" })
			require("luasnip").filetype_extend("typescript", { "typescriptreact" })
			require("luasnip").filetype_extend("javascript", { "html" })
			require("luasnip").filetype_extend("typescript", { "html" })
		end,
	},
}

local ignore = {
	"node_modules",
	".git",
	".dart_tool",
	".idea",
	".vscode",
	".github",
	".gradle",
	"venv",
	"build",
	"macos",
	"windows",
	"linux",
	"web",
	"ios",
}

require("fzf-lua").setup {
	file_ignore_patterns = ignore,
	-- winopts = {
	-- 	preview = { default = "bat" },
	-- },
}

-- Get all the commands that start with Flutter
-- local commands = vim.tbl_filter(function(cmd) return string.match(cmd, "^Flutter") end, vim.api.nvim_get_commands {})
--
-- vim.inspect(commands)

vim.keymap.set("n", "<leader>ft", require("monarch.utils.flutter").flutter_commands, { desc = "Open Flutter Tools" })

require("dressing").setup {
	select = {
		backend = { "fzf_lua", "telescope", "fzf", "builtin", "nui" },
	},
	fzf_lua = {
		window = {
			width = 0.5,
			height = 0.5,
		},
	},
}

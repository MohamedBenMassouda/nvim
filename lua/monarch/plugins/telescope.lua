local builtin = require "telescope.builtin"

local set = vim.keymap.set

-- set("n", "<leader>th", builtin.colorscheme, { desc = "ColorScheme Preview" })
-- set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tag" })

require("telescope").setup {
	defaults = {
		prompt_prefix = " 󰭎  ",
		file_ignore_patterns = { "node_modules", ".git", "venv" },
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
			},
		},
	},
	extensions = {
		live_grep_args = {
			auto_quoting = true,
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown {},
		},
		project = {
			base_dirs = {
				"/mnt/AA4C6EDE4C6EA4B3/Programming/",
			},
			hidden_files = true,
			theme = "dropdown",
		},
	},
	pickers = {
		grep_string = {
			theme = "dropdown",
		},
		colorscheme = {
			enable_preview = true,
			theme = "dropdown",
			previewer = true,
		},
		current_buffer_fuzzy_find = {
			previewer = false,
			layout_config = {
				height = 0.5,
				width = 0.5,
			},
		},
		diagnostics = {
			previewer = false,
			layout_config = {
				height = 0.5,
				width = 0.5,
			},
		},
		lsp_code_actions = {
			previewer = false,
			theme = "cursor",
			layout_config = {
				height = 0.5,
				width = 0.5,
			},
		},
		lsp_range_code_actions = {
			previewer = false,
			layout_config = {
				height = 0.5,
				width = 0.5,
			},
		},
		lsp_document_symbols = {
			previewer = false,
			layout_config = {
				height = 0.5,
				width = 0.5,
			},
		},
	},
}

-- require("telescope").load_extension "flutter"

-- vim.keymap.set(
-- 	"n",
-- 	"<leader>fs",
-- 	require("telescope").extensions.live_grep_args.live_grep_args,
-- 	{ desc = "Find Word Live" }
-- )

-- How to use project telescope
-- c to create project with the current directory
-- d to delete a project

require("telescope-lsp-handlers").setup {
	reference = {
		picker = require("telescope.themes").get_dropdown {}, -- get_dropdown generates a table, which gets merged with plugin defaults
	},
}

set(
	"n",
	"<leader>flr",
	function() require("telescope.builtin").lsp_references() end,
	{ desc = "LSP References", noremap = true, silent = true }
)

require("telescope").load_extension "fzf"
require("telescope").load_extension "dap"

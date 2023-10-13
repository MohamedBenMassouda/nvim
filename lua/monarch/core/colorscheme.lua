require("catppuccin").setup {
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	styles = {
		comments = { "italic" },
		variables = { "italic" },
	},
	integrations = {
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
		telescope = {
			enabled = true,
			style = "nvchad",
		},
	},
}

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"

local M = require "monarch.utils.colors"

for hl, col in pairs(M.change_catpuccin_treesitter_colors()) do
	vim.cmd("highlight! " .. hl .. " guifg=" .. col.fg .. " guibg=" .. (col.bg or "NONE"))
end

-- Change Treesitter Colors
-- for hl, col in pairs(M.change_catpuccin_treesitter_colors()) do
-- 	vim.cmd("highlight! " .. hl .. " guifg=" .. col.fg .. " guibg=" .. (col.bg or "NONE"))
-- end

-- Change the Highlight Color
-- for hl, col in pairs(M.catppuccin_cmpp_colors()) do
-- 	vim.cmd("highlight! " .. hl .. " guifg=" .. col.fg .. " guibg=" .. (col.bg or "NONE"))
-- end

function ColorMyPencils(color)
	vim.cmd "colorscheme catppuccin"
	vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None" })
end

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
	},
}

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"

local M = require "monarch.utils.colors"

for hl, col in pairs(M.change_catpuccin_treesitter_colors()) do
	vim.cmd("highlight! " .. hl .. " guifg=" .. col.fg .. " guibg=" .. (col.bg or "NONE"))
end

-- for hl, col in pairs(M.catppuccin_cmp_colors()) do
-- 	vim.cmd("highlight! " .. hl .. " guifg=" .. col.fg .. " guibg=" .. (col.bg or "NONE"))
-- end

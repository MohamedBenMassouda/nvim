local util = require "conform.util"
local prettier = require "conform.formatters.prettier"
local conform = require "conform"

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args) conform.format { bufnr = args.buf } end,
})

conform.setup {
	formatters_by_ft = {
		lua = { "stylua" },
		cs = { "csharpier" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		javascriptreact = { "prettierd" },
		typescriptreact = { { "prettierd" } },
		css = { "prettier" },
		json = { "prettier" },
		html = { "prettier" },
		java = { "google-java-format" },
	},
	-- format_on_save = function(bufnr)
	-- 	-- Disable with a global or buffer-local variable
	-- 	if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
	-- 		return
	-- 	end
	-- 	return { timeout_ms = 500, lsp_fallback = true }
	-- end,
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	},
}

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

conform.formatters.prettier = vim.tbl_deep_extend("force", prettier, {
	args = util.extend_args(prettier.args, { "--tab", "--indent", "2" }),
	range_args = util.extend_args(prettier.range_args, { "--tab", "--indent", "2" }),
})

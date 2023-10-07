local null_ls = require("null-ls")

-- register any number of sources simultaneously
-- local sources = {
--     null_ls.builtins.formatting.prettier,
--     null_ls.builtins.diagnostics.write_good,
--     null_ls.builtins.code_actions.gitsigns,
-- }

local lSsources = {
	null_ls.builtins.formatting.prettierd.with({
		filetypes = {
			"javascript",
			"typescript",
			"css",
			"scss",
			"html",
			"json",
			"yaml",
			"markdown",
			"graphql",
			"md",
			"txt",
		},
	}),
	null_ls.builtins.formatting.stylua.with({
		filetypes = {
			"lua",
		},
		args = { "--indent-width", "4", "--indent-type", "Spaces", "-" },
	}),
	null_ls.builtins.diagnostics.stylelint.with({
		filetypes = {
			"css",
			"scss",
		},
	}),
}

null_ls.setup({
	sources = lSsources,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			-- format on save
			vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
			vim.api.nvim_create_autocmd(event, {
				buffer = bufnr,
				group = group,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, async = async })
				end,
				desc = "[lsp] format on save",
			})
		end

		if client.supports_method("textDocument/rangeFormatting") then
			vim.keymap.set("x", "<Leader>cf", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })
		end
	end,
})

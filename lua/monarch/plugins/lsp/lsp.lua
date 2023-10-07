local lsp = require("lsp-zero")
local lsp_config = require("lspconfig")
local lsp_format = require("lsp-format")

lsp_format.setup({})
lsp_config.lua_ls.setup({ on_attach = lsp_format.on_attach })
lsp_config.dartls.setup({ on_attach = lsp_format.on_attach })

require("neodev").setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
})

lsp_config.lua_ls.setup({
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"rust_analyzer",
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

-- lsp.setup_nvim_cmp({
--     mapping = cmp_mappings
-- })

lsp.set_preferences({
	suggest_lsp_servers = true,
})

lsp.set_sign_icons({
	error = "✘",
	warn = "▲",
	hint = "⚑",
	info = "»",
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, { desc = "Code Action" })
	vim.keymap.set("n", "<leader>rr", function()
		vim.lsp.buf.references()
	end, { desc = "Find References" })
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, { desc = "Rename" })
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})

-- lspconfig["dartls"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })

require("go.format").gofmt() -- gofmt only
require("go.format").goimport() -- goimport + gofmt

-- Run gofmt + goimport on save

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimport()
	end,
	group = format_sync_grp,
})

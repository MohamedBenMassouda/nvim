local lsp = require "lsp-zero"
local lsp_config = require "lspconfig"
local lsp_format = require "lsp-format"
local cmp_nvim_lsp = require "cmp_nvim_lsp"

lsp_format.setup {}
lsp_config.lua_ls.setup { on_attach = lsp_format.on_attach }
lsp_config.dartls.setup { on_attach = lsp_format.on_attach }

lsp_config.clangd.setup {
	capabilities = cmp_nvim_lsp.default_capabilities(),
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
	},
}

lsp_config.omnisharp.setup {
	cmd = {
		"dotnet",
		"/home/monarch/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll",
	},
	enable_editorconfig_support = true,
	enable_roslyn_analysers = false,
	enable_import_completion = true,
	organize_imports_on_format = true,
	filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props" },
	analyze_open_documents_only = false,
}

-- lsp_config.pyright.setup {
-- 	settings = {
-- 		pyright = {
-- 			autoImportCompletions = true,
-- 		},
-- 	},
-- }

require("neodev").setup {
	library = { plugins = { "nvim-dap-ui" }, types = true },
}

lsp_config.lua_ls.setup {
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}

local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}

	vim.lsp.buf.execute_command(params)
end

lsp_config.tsserver.setup {
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
}

lsp_config.jdtls.setup {}

lsp.configure("intelephense", {
	settings = {
		intelephense = {
			telemetry = {
				enable = false,
			},
			environment = {
				includePaths = {
					"[...redacted...]/phpunit/vendor/*",
				},
			},
		},
	},
})

lsp.preset "recommended"

lsp.ensure_installed {
	"tsserver",
}

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

lsp.set_preferences {
	suggest_lsp_servers = true,
}

lsp.set_sign_icons {
	error = "✘",
	warn = "▲",
	hint = "",
	info = "",
}

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set(
		"n",
		"gd",
		function() vim.lsp.buf.definition() end,
		vim.list_extend(opts, { desc = "Go To Definition" })
	)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<leader>ldn", function() vim.diagnostic.goto_next() end, { desc = "Next Diagnostic" })
	vim.keymap.set("n", "<leader>ldp", function() vim.diagnostic.goto_prev() end, { desc = "Previous Diagnostic" })
	vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code Action" })
	vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, { desc = "Find References" })
	vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, { desc = "Rename" })
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<leader>ldd", vim.diagnostic.open_float, { desc = "Open Diagnostics In Float" })
	vim.keymap.set("n", "<space>ldq", vim.diagnostic.setloclist, { desc = "Open Diagnostics" })
end)

lsp.setup()

vim.diagnostic.config {
	virtual_text = true,
}

-- lspconfig["dartls"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		spacing = 5,
		severity_limit = "Warning",
	},
	update_in_insert = true,
})

require("dressing").setup {
	select = {
		backends = { "fzf_lua", "telescope", "fzf", "builtin", "nui" },
	},
}

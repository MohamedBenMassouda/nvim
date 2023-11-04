local mason_status, mason = pcall(require, "mason")

if not mason_status then return end

local masonconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")

if not masonconfig_status then return end

mason.setup()

mason_lspconfig.setup {
	ensure_installed = {
		"tsserver",
		"lua_ls",
	},
}

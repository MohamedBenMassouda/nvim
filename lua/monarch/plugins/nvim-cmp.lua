-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then return end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then return end

local lspkind = require "lspkind"

require("luasnip").filetype_extend("javascriptreact", { "html" })
require("luasnip").filetype_extend("typescriptreact", { "html" })
require("luasnip").filetype_extend("php", { "html" })
-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

lspkind.init {
	-- symbol_map = {
	--     Copilot = "",
	-- },
}

cmp.setup {
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
	end,
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
		max_width = 100,
		scrollbar = false,
	},
	snippet = {
		expand = function(args) luasnip.lsp_expand(args.body) end,
	},
	mapping = cmp.mapping.preset.insert {
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<Tab>"] = cmp.mapping.confirm { select = false },
	},
	-- sources for autocompletion
	sources = cmp.config.sources {
		-- { name = "copilot" },
		{ name = "cmp-nvim-lua" },

		{ name = "nvim_lsp" }, -- lsp
		{ name = "nvim_lsp_signature_help" },
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	},
	-- configure lspkind for vs-code like icons
	formatting = {
		format = lspkind.cmp_format {
			maxwidth = 50,
			ellipsis_char = "...",
		},
	},
}

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	sources = {
		{ name = "dap" },
	},
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

luasnip.config.set_config {
	history = true,
	enable_autosnippets = true,
}

vim.keymap.set({ "i" }, "<C-K>", function() luasnip.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() luasnip.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() luasnip.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if luasnip.choice_active() then luasnip.change_choice(1) end
end, { silent = true })

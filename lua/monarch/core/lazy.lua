local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

-- Lazy load
local plugins = {
	{
		"folke/tokyonight.nvim",
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	{
		"olimorris/onedarkpro.nvim",
	},
	-- Debugging
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"theHamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
			{
				"folke/neodev.nvim",
				opts = {},
				config = function()
					require("neodev").setup {
						library = {
							plugins = {
								"nvim-dap-ui",
							},
							types = true,
						},
					}
				end,
			},
		},
	},
	-- Debugging for Python
	{
		"mfussenegger/nvim-dap-python",
		dependencies = "mfussenegger/nvim-dap",
		ft = "python",
		config = function() require("dap-python").setup "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python" end,
	},
	{
		"nvim-lua/plenary.nvim",
	},
	-- Copilot
	{
		"github/copilot.vim",
		lazy = false,
		config = function() vim.g.copilot_assume_mapped = true end,
	},
	{ "ofseed/lualine-copilot" },
	{
		{ "catppuccin/nvim", name = "catppuccin" },
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	-- Git
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		"christoomey/vim-tmux-navigator",
	},
	{
		-- Auto Pair/Close quotes, parantheses..
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"jiangmiao/auto-pairs",
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup {
				-- Configuration here, or leave empty to use defaults
			}
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function() require("Comment").setup() end,
	},
	{
		"kyazdani42/nvim-web-devicons",
	},
	{
		-- Status Line
		"nvim-lualine/lualine.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"Slotos/telescope-lsp-handlers.nvim",
			"nvim-telescope/telescope-dap.nvim",
		},
	},
	{
		"mbbill/undotree",
	},
	{
		"windwp/nvim-ts-autotag",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup {
				autotag = {
					enable = true,
					enable_rename = true,
					enable_close = true,
					enable_close_on_slash = false,
				},
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = {
					"javascript",
					"typescript",
					"c",
					"lua",
					"dart",
					"python",
					"tsx",
					"go",
					"query",
					"vim",
					"vimdoc",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				highlight = {
					enable = true,

					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
					disable = { "dart", "python" },
				},
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
			}
		end,
		run = "TSUpdate",
	},

	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "rcarriga/cmp-dap" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },

			-- LSP Formating
			{ "lukas-reineke/lsp-format.nvim" },

			-- Lsp Diagnostics
			{ "folke/trouble.nvim" },

			-- Lsp kind
			{
				"onsails/lspkind-nvim",
				config = function() require("lspkind").init() end,
			},

			-- Lsp Usage
			{
				"Wansmer/symbol-usage.nvim",
				event = { "BufReadPre", "LspAttach" }, -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
				config = function() require("symbol-usage").setup() end,
			},
		},
	},
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		ft = "dart",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
	},
	{
		"Nash0x7E2/awesome-flutter-snippets",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			background_colour = "#000000",
		},
		config = function(_, opts)
			require("notify").setup(vim.tbl_extend("keep", {
				-- other stuff
				background_colour = "#000000",
			}, opts))
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
		config = function() require("ibl").setup() end,
	},

	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			require("rainbow-delimiters.setup").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end,
	},

	{
		"echasnovski/mini.cursorword",
		dependencies = {
			"echasnovski/mini.extra",
			"echasnovski/mini.pick",
		},
		version = false,
		config = function()
			require("mini.cursorword").setup()
			require("mini.extra").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"nvim-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function() vim.b.miniindentscope_disable = true end,
			})
		end,
	},
	-- {
	-- 	"dart-lang/dart-vim-plugin",
	-- },
	-- Git Blame Messages
	{
		"rhysd/git-messenger.vim",
	},
	{
		"nvim-pack/nvim-spectre",
		opts = {},
	},
	{
		"ray-x/go.nvim",
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"leoluz/nvim-dap-go",
		},
		config = function()
			-- Check if a go project then setup
			require("go").setup()

			require("go.format").goimport() -- goimport + gofmt

			-- Run gofmt + goimport on save
			local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function() require("go.format").goimport() end,
				group = format_sync_grp,
			})
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		config = function() require("nvim-highlight-colors").setup {} end,
	},
	{
		"DNLHC/glance.nvim",
	},
	{
		"andymass/vim-matchup",
		config = function() vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
	},
	-- Rust
	-- {
	-- 	"simrat39/rust-tools.nvim",
	-- 	ft = { "rust" },
	-- 	opt = {},
	-- 	config = function() require("rust-tools").inlay_hints.enable() end,
	-- },
	-- {
	-- 	"saecki/crates.nvim",
	-- 	tag = "v0.4.0",
	-- 	ft = { "rust", "toml" },
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = function() require("crates").setup() end,
	-- },
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	{
		"mfussenegger/nvim-lint",
	},
	{
		"nvim-treesitter/playground",
	},
	{
		"ThePrimeagen/harpoon",
	},
	-- Color Picker
	-- {
	--     "ziontee113/color-picker.nvim",
	--     config = function() require("color-picker").setup {} end,
	--     ft = { "css", "ts", "tsx", "jsx", "dart" },
	-- },
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup {
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			}
		end,
	},
	{
		"ibhagwan/fzf-lua",
	},
	{
		"luckasRanarison/clear-action.nvim",
		event = "LspAttach",
		opts = {
			mappings = {
				code_action = {
					"<leader>ca",
				},
			},
		},
	},
	{
		"nvim-java/nvim-java",
		dependencies = {
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"MunifTanjim/nui.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			{
				"williamboman/mason.nvim",
				opts = {
					registries = {
						"github:nvim-java/mason-registry",
						"github:mason-org/mason-registry",
					},
				},
			},
		},
		config = function() require("java").setup() end,
	},
	{
		"ggandor/leap.nvim",
		config = function() require("leap").add_default_mappings() end,
	},
	{
		"Hoffs/omnisharp-extended-lsp.nvim",
		lazy = true,
		ft = { "cs" },
	},
	{
		"tiagovla/tokyodark.nvim",
		opts = {},
		config = function(_, opts)
			require("tokyodark").setup {
				transparent_background = true,
			}
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = { "markdown" },
	},
}

require("lazy").setup(plugins)

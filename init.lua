local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Lazy load
local plugins = {
    {
        "folke/tokyonight.nvim",
    },
    -- Debugging
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            'mfussenegger/nvim-dap',
            'theHamsta/nvim-dap-virtual-text',
            'jay-babu/mason-nvim-dap.nvim',
            'leoluz/nvim-dap-go',
            'mfussenegger/nvim-dap-python',
            {
                'folke/neodev.nvim',
                opts = {}
            }
        }
    },
    {
        "nvim-lua/plenary.nvim"
    },
    -- Copilot
    {
        "github/copilot.vim",
        lazy = false,
        config = function()
            vim.g.copilot_assume_mapped = true
        end
    },
    { "ofseed/lualine-copilot" },
    {
        { "catppuccin/nvim", name = "catppuccin" }
    },
    {
        { 'akinsho/toggleterm.nvim', version = "*", }
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
        }
    },
    -- Git
    {
        "lewis6991/gitsigns.nvim",
        opts = {}
    },
    {
        "christoomey/vim-tmux-navigator",
    },
    {
        -- Auto Pair/Close quotes, parantheses..
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    {
        'jiangmiao/auto-pairs'
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require("Comment").setup()
        end
    },
    {
        "kyazdani42/nvim-web-devicons"
    },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        -- config = function()
        --     vim.g.loaded_netrw = 1
        --     vim.g.loaded_netrwPlugin = 1
        --
        --     -- set termguicolors to enable highlight groups
        --     vim.opt.termguicolors = true
        --
        --
        --     -- OR setup with some options
        --     require("nvim-tree").setup({
        --         sort_by = "case_sensitive",
        --         view = {
        --             width = 30,
        --             float = {
        --                 enable = true,
        --                 quit_on_focus_loss = true,
        --                 open_win_config ={
        --                     relative = "editor",
        --                     border = "rounded",
        --                     width = 30,
        --                     height = 30,
        --                     row = 1,
        --                     col = 1,
        --                 }
        --             },
        --         },
        --         renderer = {
        --             group_empty = true,
        --         },
        --         filters = {
        --             dotfiles = true,
        --         },
        --         diagnostics = {
        --             enable = true,
        --             show_on_dirs = true,
        --             show_on_open_dirs = false,
        --             debounce_delay = 50,
        --             severity = {
        --                 min = vim.diagnostic.severity.HINT,
        --                 max = vim.diagnostic.severity.ERROR,
        --             },
        --             icons = {
        --                 hint = "",
        --                 info = "",
        --                 warning = "",
        --                 error = "",
        --             },
        --         },
        --     })
        -- end
    },
    {
        -- Status Line
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup {
                options = {
                    theme = "tokyonight",
                    icons_enabled = true,
                    globalstatus = true,
                },
                sections = {
                    lualine_x = {
                        "copilot",
                        "filetype",
                        "encoding",
                        "fileformat",
                    }
                }
            }
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-telescope/telescope-ui-select.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-project.nvim",
            "Slotos/telescope-lsp-handlers.nvim",
            'nvim-telescope/telescope-dap.nvim',
        },
        config = function()
            require("telescope").setup(opts)
        end,
    },
    {
        "mbbill/undotree"
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require("nvim-treesitter.install").prefer_git = true
            require 'nvim-treesitter.configs'.setup {
                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = { "javascript", "typescript", "c", "lua", "dart", "python", "tsx" },

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
                    disable = { "dart" }
                }
            }
        end,
        run = 'TSUpdate'
    },

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            -- LSP Formating
            { "lukas-reineke/lsp-format.nvim" },

            -- Lsp Diagnostics
            { 'folke/trouble.nvim' },

            -- Lsp Signature
            { 'ray-x/lsp_signature.nvim' },

            -- Lsp Code Actions
            {
                'kosayoda/nvim-lightbulb',
                opts = {}
            },

            -- Lsp kind
            {
                'onsails/lspkind-nvim',
                config = function()
                    require('lspkind').init()
                end
            },
        }
    },
    {
        'akinsho/flutter-tools.nvim',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
    },
    {
        "Nash0x7E2/awesome-flutter-snippets"
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            'MunifTanjim/nui.nvim',
            "rcarriga/nvim-notify"
        },
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true,       -- add a border to hover docs and signature help
                },
            })
        end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            -- char = "▏",
            char = "│",
            filetype_exclude = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
            show_trailing_blankline_indent = false,
            show_current_context = false,
        },
    },

    {
        "echasnovski/mini.cursorword",
        version = "*",
        config = function()
            require("mini.cursorword").setup()
        end
    },
    {
        'echasnovski/mini.surround',
        version = "*",
        config = function()
            require("mini.surround").setup()
        end
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
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    {
        'mawkler/modicator.nvim',
        init = function()
            -- These are required for Modicator to work
            vim.o.cursorline = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        config = function()
            require('modicator').setup()
        end,
    },
    {
        'dart-lang/dart-vim-plugin',
    },
    -- Git Blame Messages
    {
        'rhysd/git-messenger.vim'
    },
    {
        "nvim-pack/nvim-spectre",
        opts = {}
    },
    {
        "lalitmee/browse.nvim",
    },
    {
        "ray-x/go.nvim",
        dependencies = {  -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
}


require("lazy").setup(plugins)
require("monarch.core.keymaps")
require("monarch.core.options")
require("monarch.core.colorscheme")
require("monarch.plugins")

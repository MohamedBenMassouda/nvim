local builtin = require('telescope.builtin')

local set = vim.keymap.set

set("n", "<leader>th", builtin.colorscheme, { desc = "ColorScheme Preview" })
set("n", "<leader>h", builtin.help_tags, { desc = "Help Tag" })

require("telescope").setup {
    extensions = {
        live_grep_args = {
            auto_quoting = true,
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {

            }
        }
    },
    pickers = {
        colorscheme = {
            enable_preview = true
        }
    }
}

require("telescope").load_extension("flutter")

require("telescope").load_extension("ui-select")
vim.keymap.set('n', '<leader>fs', require("telescope").extensions.live_grep_args.live_grep_args,
    { desc = "Find Word Live" })


require("telescope").load_extension("file_browser")
-- How to use project telescope
-- c to create project with the current directory
-- d to delete a project
vim.api.nvim_set_keymap(
    'n',
    '<C-p>',
    ":lua require'telescope'.extensions.project.project{}<CR>",
    { desc = "Find added Projects With Telescope" }
)

vim.api.nvim_set_keymap(
    "n",
    "<space>fp",
    ":Telescope file_browser<CR>",
    { desc = "Browse Files With Telescope" }
)

require 'telescope-lsp-handlers'.setup({
    reference = {
        picker = require('telescope.themes').get_dropdown({}), -- get_dropdown generates a table, which gets merged with plugin defaults
    },
})

vim.keymap.set('n', '<leader>flr', function() require('telescope.builtin').lsp_references() end,
    { desc = "LSP References", noremap = true, silent = true })

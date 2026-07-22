local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = 0 }

-- .NET conventions: 4-space indentation, spaces not tabs
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

-- treesitter main's indenter mis-indents C#; use C-style indentation instead
vim.bo.indentexpr = ""
vim.bo.cindent = true

-- Roslyn provides inlay hints, but Neovim won't show them unless enabled
vim.lsp.inlay_hint.enable(true, { bufnr = 0 })

-- Code lens (reference counts, "run test" lenses) — refresh + run
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "TextChanged" }, {
  buffer = 0,
  callback = function()
    vim.lsp.codelens.refresh({ bufnr = 0 })
  end,
})
map("n", "<leader>cl", vim.lsp.codelens.run, vim.tbl_extend("force", opts, { desc = "Run code lens" }))

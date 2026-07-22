return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  keys = {
    { "<leader>go", "<cmd>DiffviewOpen<cr>",          desc = "Diffview: open" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: file history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Diffview: branch history" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>",         desc = "Diffview: close" },
  },
}

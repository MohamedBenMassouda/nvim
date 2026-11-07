return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    spec = {
      { "<leader>d", group = "Debug" },
      { "<leader>q", group = "Session" },
      { "<leader>r", group = "Rename/Refactor" },
      { "<leader>t", group = "Test" },
      { "<leader>u", group = "UI" },
    },
  },
}

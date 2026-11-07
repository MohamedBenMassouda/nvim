return {
  {
    -- Task runner: wrangler dev, dotnet watch, cargo run, go run, .vscode/tasks.json
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle", "OverseerTaskAction" },
    keys = {
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run Task" },
      { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle Task List" },
      { "<leader>oa", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
    },
    opts = {},
  },
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Coverage", "CoverageLoad", "CoverageToggle", "CoverageSummary" },
    keys = {
      { "<leader>tc", "<cmd>Coverage<cr>", desc = "Coverage: load + show" },
      { "<leader>tC", "<cmd>CoverageSummary<cr>", desc = "Coverage: summary" },
    },
    opts = { auto_reload = true },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Chat" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
      { "<leader>ai", ":CodeCompanion ", mode = { "n", "v" }, desc = "AI Inline Edit" },
    },
    opts = {},
  },
}

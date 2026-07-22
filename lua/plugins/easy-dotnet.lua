return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  ft = { "cs", "fsharp", "razor" },
  cmd = "Dotnet",
  keys = {
    { "<leader>tt", "<cmd>Dotnet testrunner<cr>", desc = "Test runner (open/close)" },
  },
  config = function()
    require("easy-dotnet").setup({
      -- lsp = { enabled = false },
      test_runner = {
        viewmode = "float", -- "split" | "vsplit" | "float" | "buf"
        mappings = {
          -- buffer integration (on test files) — namespaced to avoid <leader>d / <leader>t clashes
          run_test_from_buffer         = { lhs = "<leader>Tr", desc = "Run test under cursor" },
          run_all_tests_from_buffer    = { lhs = "<leader>Ta", desc = "Run all tests in file" },
          debug_test_from_buffer       = { lhs = "<leader>TD", desc = "Debug test under cursor" },
          peek_stack_trace_from_buffer = { lhs = "<leader>Tp", desc = "Peek stacktrace" },
        },
      },
    })
  end,
}

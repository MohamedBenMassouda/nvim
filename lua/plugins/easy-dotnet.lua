-- Test running moved to neotest (see lua/plugins/neotest.lua).
-- easy-dotnet kept for its non-test features (Dotnet command: run/build/secrets/etc).
return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
  ft = { "cs", "fsharp", "razor" },
  cmd = "Dotnet",
  config = function()
    require("easy-dotnet").setup({
      picker = "fzf",
      config = {
        ft = "cs",
      },
      -- neotest drives .NET tests (see lua/plugins/neotest.lua).
      -- Disables easy-dotnet's own buffer signs/keymaps so neotest manages them.
      test_runner = {
        neotest_integration = true,
      },
      -- easy-dotnet only supports "integratedTerminal" | "externalTerminal".
      -- integratedTerminal renders the debuggee's output into nvim-dap-ui's
      -- `console` element (added to the dap layout in dap.lua). Supports stdin.
      debugger = {
        console = "integratedTerminal",
      },
    })
  end,
}

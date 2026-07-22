return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  ft = { "cs", "fsharp", "razor" },
  cmd = "Dotnet",
  config = function()
    require("easy-dotnet").setup({
      lsp = {
        enabled = false, -- roslyn.nvim is the C# LSP; don't start a second server
      },
    })
  end,
}

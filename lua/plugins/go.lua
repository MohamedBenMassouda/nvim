return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    {
      "leoluz/nvim-dap-go",
      ft = "go",
      config = function()
        require("dap-go").setup()
      end,
    },
  },
  ft = { "go", "gomod" },
  cmd = { "GoRun", "GoTest", "GoBuild", "GoImports", "GoFmt" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  config = function()
    -- Check if a go project then setup
    require("go").setup()

    -- Formatting on save is conform.nvim's job (goimports + gofumpt).
    -- go.nvim used to register its own BufWritePre goimport here, which
    -- meant every .go save was formatted twice.
  end,
}

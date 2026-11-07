return {
  {
    -- DB browser; D1 local state is SQLite under .wrangler/state
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = { { "<leader>D", "<cmd>DBUIToggle<cr>", desc = "Database UI" } },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sR",
        function()
          require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
        end,
        mode = { "n", "x" },
        desc = "Search and Replace in Project",
      },
    },
    opts = {},
  },
}

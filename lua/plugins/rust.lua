return {
  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    lazy = false, -- This plugin is already lazy
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              -- clippy on save: idiomatic-Rust hints while learning
              check = { command = "clippy" },
            },
          },
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    opts = {
      completion = { crates = { enabled = true } },
      lsp = { enabled = true, actions = true, completion = true, hover = true },
    },
  },
}

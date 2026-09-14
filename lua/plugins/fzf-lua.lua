return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local ignore = {
        "**/*.class/*",
        "node_modules",
        ".git",
        ".dart_tool",
        ".idea",
        ".vscode",
        ".gradle",
        "venv",
        "build",
        "macos",
        "windows",
        "linux",
        "web",
        "ios",
        "android",
        "@girs",
      }

      require("fzf-lua").setup({
        file_ignore_patterns = ignore,
        files = {
          hidden = true,
        },
        -- winopts = {
        -- 	preview = { default = "bat" },
        -- },
      })
    end,
  },
}

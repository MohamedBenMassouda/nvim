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
        ".github",
        ".gradle",
        "venv",
        "build",
        "macos",
        "windows",
        "linux",
        "web",
        "ios",
        "android",
      }

      require("fzf-lua").setup {
        file_ignore_patterns = ignore,
        -- winopts = {
        -- 	preview = { default = "bat" },
        -- },
      }
    end,
  },
}

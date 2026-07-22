return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset        = "enter",
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },

        ["<C-j>"]     = { "snippet_forward", "fallback" },
        ["<C-k>"]     = { "snippet_backward", "fallback" },

        ["<C-u>"]     = { "scroll_documentation_down", "fallback" },
        ["<C-d>"]     = { "scroll_documentation_up", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      snippets = { preset = "luasnip" },
      sources = { default = { "lsp", "snippets", "path", "buffer" } },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = true },
        menu = {
          border = "rounded",
          draw = {
            columns = {
              { "kind_icon" },
              { "label",    "label_description", gap = 1 },
              { "kind" },
            },
          },
        },
      },
      signature = { enabled = true },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
      require("blink.cmp").setup(opts)

      local kind_colors = {
        Method = "#B180D7",
        Function = "#B180D7",
        Constructor = "#B180D7",   -- purple
        Field = "#6EA8FF",
        Property = "#6EA8FF",      -- blue
        Variable = "#8FBCE6",
        TypeParameter = "#8FBCE6", -- light blue
        Class = "#F2C55C",
        Module = "#E5C07B",        -- gold
        Interface = "#5FC9BF",
        Struct = "#4EC9B0",        -- teal
        Enum = "#DCDCAA",
        EnumMember = "#B5CEA8",    -- yellow/green
        Constant = "#C586C0",      -- magenta
        Keyword = "#E06C75",       -- red
        Snippet = "#98C379",
        Operator = "#56B6C2",
        Text = "#ABB2BF",
        Color = "#D19A66",
        File = "#7FB4CA",
        Reference = "#7FB4CA",
        Folder = "#7FB4CA",
        Event = "#D19A66",
        Unit = "#D19A66",
        Value = "#D19A66",
      }
      local apply = function()
        for kind, color in pairs(kind_colors) do
          vim.api.nvim_set_hl(0, "BlinkCmpKind" .. kind, { fg = color })
        end
      end
      apply()
      -- Reapply after any colorscheme change so the colors stick
      vim.api.nvim_create_autocmd("ColorScheme", { callback = apply })
    end,
  },
}

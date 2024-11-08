return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    { 'AndreM222/copilot-lualine' },
  },
  config = function()
    require("lualine").setup {
      options = {
        icons_enabled = false,      -- Disable icons for a minimal look
        component_separators = '|', -- Separator between components
        section_separators = '',    -- No section separators
        theme = {
          normal = {
            a = 'StatusLine',
            b = 'StatusLine',
            c = 'StatusLine',
          },
          insert = {
            a = 'StatusLine',
            b = 'StatusLine',
            c = 'StatusLine',
          },
          visual = {
            a = 'StatusLine',
            b = 'StatusLine',
            c = 'StatusLine',
          },
          replace = {
            a = 'StatusLine',
            b = 'StatusLine',
            c = 'StatusLine',
          },
          command = {
            a = 'StatusLine',
            b = 'StatusLine',
            c = 'StatusLine',
          },
          inactive = {
            a = 'StatusLineNC',
            b = 'StatusLineNC',
            c = 'StatusLineNC',
          },
        },
      },
      sections = {
        lualine_a = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_b = {
          "branch",
          {
            "diff",
            colored = true,
          },
        },
        lualine_c = {
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            sections = { "error", "warn", "info", "hint" },
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
            color_error = "#fb4934",
            color_warn = "#fabd2f",
            color_info = "#83a598",
            color_hint = "#8ec07c",
          },
        },
        lualine_x = {
          {
            "copilot",
            -- symbols = {
            --   status = {
            --     enabled = " ",
            --     disabled = " ",
            --   },
            --   spinners = { " ", " ", " ", " " },
            --   -- spinners = require("copilot-status.spinners").dots
            -- },
          },
        },
      },
    }
  end
}

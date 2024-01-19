local custom_theme = require "lualine.themes.tokyonight"

local color = "#fb4934"
custom_theme.insert.a.bg = color
custom_theme.insert.b.fg = color

require("lualine").setup {
    options = {
        theme = custom_theme,
        icons_enabled = true,
        globalstatus = true,
    },
    sections = {
        lualine_x = {
            {
                "copilot",
                show_running = true,
                symbols = {
                    status = {
                        enabled = " ",
                        disabled = " ",
                    },
                    spinners = { " ", " ", " ", " " },
                    -- spinners = require("copilot-status.spinners").dots
                },
            },
            "filetype",
            "encoding",
            "fileformat",
        },
    },
}

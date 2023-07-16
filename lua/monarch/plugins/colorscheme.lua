return {
    "folke/tokyonight.nvim",
    lazy = false,
    config = function(_, opts)
        local tokyonight = require("tokyonight")
        tokyonight.setup(opts)
        tokyonight.load()
    end,
}

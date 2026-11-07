return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "javascript",
        "typescript", -- required by neotest-vitest to discover describe/it inside .ts files
        "tsx",
        "html",
        "c_sharp",
        "python",
        "go",
        "gomod",
        "rust",
        "json",
        "yaml",
        "toml",
        "bash",
        "css",
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ok = pcall(vim.treesitter.start)
          if ok and vim.bo[args.buf].filetype ~= "cs" then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select = require("nvim-treesitter-textobjects.select").select_textobject
      for lhs, query in pairs({
        af = "@function.outer",
        ["if"] = "@function.inner",
        ac = "@class.outer",
        ic = "@class.inner",
        aa = "@parameter.outer",
        ia = "@parameter.inner",
      }) do
        vim.keymap.set({ "x", "o" }, lhs, function()
          select(query, "textobjects")
        end, { desc = query })
      end

      local move = require("nvim-treesitter-textobjects.move")
      for lhs, args in pairs({
        ["]f"] = { move.goto_next_start, "@function.outer" },
        ["[f"] = { move.goto_previous_start, "@function.outer" },
        ["]C"] = { move.goto_next_start, "@class.outer" },
        ["[C"] = { move.goto_previous_start, "@class.outer" },
      }) do
        vim.keymap.set({ "n", "x", "o" }, lhs, function()
          args[1](args[2], "textobjects")
        end, { desc = args[2] })
      end
    end,
  },
}

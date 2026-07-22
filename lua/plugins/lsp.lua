return {
  {
    "luckasRanarison/clear-action.nvim",
    event = "LspAttach",
    opts = {
      mappings = {
        code_action = { "<leader>ca" },
      },
    },
  },
  { "artemave/workspace-diagnostics.nvim" },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    opts = {}
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      -- Diagnostics keymaps (global; not LSP-exclusive)
      vim.keymap.set("n", "gl", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end)
      vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end)

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
          -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<F2>", function() return ":IncRename " .. vim.fn.expand("<cword>") end,
            vim.tbl_extend("force", opts, { expr = true }))
          vim.keymap.set("n", "<leader>rn", function() return ":IncRename " .. vim.fn.expand("<cword>") end,
            vim.tbl_extend("force", opts, { expr = true }))
          vim.keymap.set({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end, opts)
          vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
        end,
      })

      -- Apply cmp capabilities to every server, including roslyn
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        on_attach = function(client, bufnr)
          -- some clients support workspace diagnostics natively
          if client:supports_method("workspace/diagnostic", bufnr) then
            vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
          else
            require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
          end
        end
      })

      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry", -- provides the roslyn server
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        -- automatic_enable is on by default: installed servers get vim.lsp.enable'd
      })
    end,
  },
}

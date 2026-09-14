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
  { "artemave/workspace-diagnostics.nvim", lazy = true },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      -- Diagnostics keymaps (global; not LSP-exclusive)
      vim.keymap.set("n", "gl", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1 })
      end)
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1 })
      end)

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
          vim.keymap.set("n", "<F2>", function()
            return ":IncRename " .. vim.fn.expand("<cword>")
          end, vim.tbl_extend("force", opts, { expr = true }))
          vim.keymap.set("n", "<leader>rn", function()
            return ":IncRename " .. vim.fn.expand("<cword>")
          end, vim.tbl_extend("force", opts, { expr = true }))
          vim.keymap.set({ "n", "x" }, "<F3>", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
          vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
        end,
      })

      -- Pull diagnostics for the whole project, not just open buffers. This used
      -- to run from on_attach, which meant every first file open pushed every
      -- file in the solution/repo to the server before you could type. Cheap on
      -- Linux, seconds on macOS, so macOS gets it on demand instead.
      local function workspace_diagnostics(client, bufnr)
        if client:supports_method("workspace/diagnostic", bufnr) then
          vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
        else
          require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
        end
      end

      vim.keymap.set("n", "<leader>xw", function()
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          workspace_diagnostics(client, 0)
        end
      end, { desc = "Load workspace diagnostics" })

      -- Apply cmp capabilities to every server, including roslyn
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        on_attach = not vim.g.is_mac and workspace_diagnostics or nil,
      })

      -- basedpyright: pyright fork that adds inlay hints. Its own default
      -- typeCheckingMode is "recommended", which errors on untyped third-party
      -- code in most real projects, so pin it back to pyright's "standard".
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
              autoImportCompletions = true,
              -- openFilesOnly keeps startup off the whole-repo critical path
              diagnosticMode = "openFilesOnly",
              inlayHints = {
                variableTypes = true,
                callArgumentNames = true,
                functionReturnTypes = true,
                genericTypes = false,
              },
            },
          },
        },
      })

      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry", -- provides the roslyn server
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsc", "basedpyright" },
        -- automatic_enable is on by default: installed servers get vim.lsp.enable'd
      })
    end,
  },
}

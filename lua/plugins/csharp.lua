return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      local netcoredbg = {
        type = "executable",
        command = vim.fn.exepath("netcoredbg"),
        args = { "--interpreter=vscode" },
        options = { detached = false },
      }
      dap.adapters.netcoredbg = dap.adapters.netcoredbg or netcoredbg
      -- .vscode/launch.json configs use "coreclr" (the VSCode C# extension's
      -- adapter name). nvim-dap has no such adapter, so those configs (e.g.
      -- "Debug Test Harness") can't resolve one and the session dies instantly
      -- ("starts and ends at the same time"). Alias coreclr to netcoredbg.
      dap.adapters.coreclr = dap.adapters.coreclr or netcoredbg

      -- Make easy-dotnet the default debug action for .NET buffers: <leader>ds
      -- runs its config directly (skips the config picker); once a session is
      -- live it just continues. The other configs (launch.json etc.) are still
      -- reachable via <leader>dc, which keeps the picker.
      local function debug_dotnet()
        if dap.session() then
          dap.continue()
          return
        end
        local cfg = vim.iter(dap.configurations.cs or {}):find(function(c)
          return c.type == "easy-dotnet"
        end)
        if cfg then
          dap.run(cfg)
        else
          dap.continue() -- easy-dotnet not registered yet; fall back to picker
        end
      end
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "cs", "fsharp", "vb", "razor" },
        callback = function(ev)
          vim.keymap.set("n", "<leader>ds", debug_dotnet, {
            buffer = ev.buf,
            desc = "Debug: Start (easy-dotnet) / Continue",
          })
        end,
      })
    end,
  },
  -- {
  --   "seblyng/roslyn.nvim",
  --   ft = { "cs", "razor" },
  --   ---@module 'roslyn.config'
  --   ---@type RoslynNvimConfig
  --   opts = {
  --     broad_search = true,
  --   },
  --   init = function()
  --     vim.lsp.config("roslyn", {
  --       settings = {
  --         ["csharp|completion"] = {
  --           dotnet_show_completion_items_from_unimported_namespaces = true,
  --           dotnet_show_name_completion_suggestions = true,
  --         },
  --         ["csharp|inlay_hints"] = {
  --           csharp_enable_inlay_hints_for_implicit_object_creation = true,
  --           csharp_enable_inlay_hints_for_implicit_variable_types = true,
  --           csharp_enable_inlay_hints_for_lambda_parameter_types = true,
  --           csharp_enable_inlay_hints_for_types = true,
  --           dotnet_enable_inlay_hints_for_parameters = true,
  --         },
  --         ["csharp|code_lens"] = {
  --           dotnet_enable_references_code_lens = true,
  --           dotnet_enable_tests_code_lens = true,
  --         },
  --         ["csharp|background_analysis"] = {
  --           dotnet_analyzer_diagnostics_scope = "fullSolution",
  --           dotnet_compiler_diagnostics_scope = "fullSolution",
  --         },
  --         ["csharp|symbol_search"] = {
  --           dotnet_search_reference_assemblies = true,
  --         },
  --         ["csharp|formatting"] = {
  --           dotnet_organize_imports_on_format = true,
  --         },
  --       },
  --     })
  --   end,
  -- },
}

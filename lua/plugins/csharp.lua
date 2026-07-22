return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      if not dap.adapters["netcoredbg"] then
        dap.adapters["netcoredbg"] = {
          type = "executable",
          command = vim.fn.exepath("netcoredbg"),
          args = { "--interpreter=vscode" },
          options = { detached = false },
        }
      end
      for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = "netcoredbg",
              name = "Launch file",
              request = "launch",
              ---@diagnostic disable-next-line: redundant-parameter
              program = function()
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
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

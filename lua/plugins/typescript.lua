return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      -- js-debug (VS Code's JS debugger) from Mason
      dap.adapters["pwa-node"] = dap.adapters["pwa-node"]
        or {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = { command = "js-debug-adapter", args = { "${port}" } },
        }

      local configs = {
        {
          -- `wrangler dev` exposes the V8 inspector on 9229 by default
          type = "pwa-node",
          request = "attach",
          name = "Attach to wrangler dev (9229)",
          port = 9229,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          skipFiles = { "<node_internals>/**", "**/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch current file (node)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
      }
      for _, ft in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[ft] = dap.configurations[ft] or configs
      end
    end,
  },
}

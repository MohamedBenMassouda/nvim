return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        icons = {
          expanded = "▾",
          collapsed = "▸",
          current_frame = "▸",
        },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        -- Current nvim-dap-ui uses `layouts` (the old sidebar/tray keys were
        -- silently ignored). Left column: scopes/breakpoints/stacks/watches.
        -- Bottom: repl.
        layouts = {
          {
            position = "left",
            size = 40,
            elements = {
              { id = "scopes", size = 0.30 },
              { id = "breakpoints", size = 0.20 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
          },
          {
            position = "bottom",
            size = 10,
            elements = {
              -- `console` = debuggee stdout/stderr + build output (easy-dotnet
              -- integratedTerminal renders here). `repl` = dap REPL.
              { id = "console", size = 0.5 },
              { id = "repl", size = 0.5 },
            },
          },
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          mappings = { close = { "q", "<Esc>" } },
        },
      })

      require("nvim-dap-virtual-text").setup({}) -- inline variable values while stepping

      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })

      -- easy-dotnet's .NET debug flow is a two-phase trampoline: the first
      -- continue aborts and reschedules via `Dotnet debug profile`, which builds
      -- then starts the real attach session. Opening the UI on `event_initialized`
      -- renders it before any frame exists (empty until you re-toggle). Opening
      -- again on the first `event_stopped` guarantees a populated, live render.
      local function open_ui()
        dapui.open()
      end
      dap.listeners.after.event_initialized["dapui_config"] = open_ui
      dap.listeners.after.event_stopped["dapui_config"] = open_ui
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )
      vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )
      vim.fn.sign_define(
        "DapLogPoint",
        { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
      )
      -- 
      vim.fn.sign_define(
        "DapStopped",
        { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
      )
    end,
  },
  {
    "mfussenegger/nvim-dap",
    opts = {
      automatic_setup = true,
    },
    config = function()
      local dap = require("dap")

      -- Session control
      vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<leader>dS", dap.terminate, { desc = "Debug: Stop (terminate)" })
      vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Debug: Restart" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
      -- Stepping
      vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Debug: Pause" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
      -- Breakpoints
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Conditional Breakpoint" })
      -- Inspect value under cursor / selection
      vim.keymap.set({ "n", "v" }, "<leader>de", function()
        require("dapui").eval()
      end, { desc = "Debug: Eval under cursor" })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    after = "nvim-dap",
    config = function()
      require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/")
    end,
  },
  {
    -- Ensures the .NET debugger (netcoredbg) is installed via Mason.
    -- easy-dotnet auto-registers the `cs` dap config (auto_register_dap=true),
    -- which picks the project/profile and attaches to netcoredbg.
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mason-org/mason.nvim" },
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      ensure_installed = { "netcoredbg" },
      automatic_installation = true,
      handlers = {}, -- keep default adapter registration
    },
  },
}

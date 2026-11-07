return {
  {
    -- Loads on first debug key (or when another plugin requires "dap"),
    -- not at startup.
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = function()
      local function d(fn)
        return function()
          require("dap")[fn]()
        end
      end
      return {
        -- Session control
        { "<leader>ds", d("continue"), desc = "Debug: Start/Continue" },
        { "<leader>dc", d("continue"), desc = "Debug: Start/Continue" },
        { "<leader>dS", d("terminate"), desc = "Debug: Stop (terminate)" },
        { "<leader>dr", d("restart"), desc = "Debug: Restart" },
        { "<leader>dl", d("run_last"), desc = "Debug: Run Last" },
        -- Stepping
        { "<leader>dp", d("pause"), desc = "Debug: Pause" },
        { "<leader>di", d("step_into"), desc = "Debug: Step Into" },
        { "<leader>do", d("step_over"), desc = "Debug: Step Over" },
        { "<leader>dO", d("step_out"), desc = "Debug: Step Out" },
        -- Breakpoints
        { "<leader>db", d("toggle_breakpoint"), desc = "Debug: Toggle Breakpoint" },
        { "<leader>b", d("toggle_breakpoint"), desc = "Toggle Breakpoint" },
        {
          "<leader>dB",
          function()
            require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
          end,
          desc = "Debug: Conditional Breakpoint",
        },
        -- UI / inspect value under cursor or selection
        {
          "<leader>du",
          function()
            require("dapui").toggle()
          end,
          desc = "Debug: Toggle UI",
        },
        {
          "<leader>de",
          function()
            require("dapui").eval()
          end,
          mode = { "n", "v" },
          desc = "Debug: Eval under cursor",
        },
      }
    end,
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
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      require("dap-python").setup("debugpy-adapter")
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

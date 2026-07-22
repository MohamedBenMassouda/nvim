-- Test runner (neotest) — single runner for all languages.
-- Rider-like results window = the neotest summary (<leader>ts) + output panel (<leader>tO).
-- Adapters are language-agnostic: add/remove entries in `adapters` below for new languages.
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Language adapters
    "GustavEikaas/easy-dotnet.nvim", -- C# / F# / VB (.NET) — maintained adapter (Issafalcon/neotest-dotnet broke on nvim 0.12)
    -- "nvim-neotest/neotest-jest",       -- JavaScript / TypeScript (Jest)
    -- "marilari88/neotest-vitest",       -- JavaScript / TypeScript (Vitest)
    -- "nvim-neotest/neotest-python",     -- Python
    -- "fredrikaverpil/neotest-golang",   -- Go
    -- "nvim-neotest/neotest-plenary",    -- Lua (plenary busted)
  },
  config = function()
    local neotest = require("neotest")

    -- Fix for easy-dotnet's .NET adapter: the RPC server returns start/end line = nil
    -- for xUnit [Fact] methods (Theories come back fine), so their neotest range
    -- collapses to {0,0,0,0}. Consequences: run-nearest on a Fact falls back to the
    -- whole class, and the pass/fail sign lands on line 0 (invisible).
    -- We backfill those ranges from treesitter by matching each position's trailing
    -- "::method:<name>" id segment against the method's DisplayName / identifier.
    local dotnet = require("easy-dotnet.neotest")
    do
      local ts = vim.treesitter
      -- name (DisplayName and/or method identifier) -> 0-based {s,0,e,0} range
      local function method_range_map(file_path)
        local fh = io.open(file_path, "r")
        if not fh then return {} end
        local src = fh:read("*a")
        fh:close()
        local ok, parser = pcall(ts.get_string_parser, src, "c_sharp")
        if not ok or not parser then return {} end
        local root = parser:parse()[1]:root()
        local q = ts.query.parse("c_sharp", "(method_declaration) @m")
        local map = {}
        for _, node in q:iter_captures(root, src) do
          local s_row, _, e_row = node:range()
          local range = { s_row, 0, e_row, 0 }
          local name_node = node:field("name")[1]
          if name_node then map[ts.get_node_text(name_node, src)] = range end
          -- DisplayName from the method's attribute list(s), if any
          for child in node:iter_children() do
            if child:type() == "attribute_list" then
              local display = ts.get_node_text(child, src):match('DisplayName%s*=%s*"(.-)"')
              if display then map[display] = range end
            end
          end
        end
        return map
      end

      local orig_discover = dotnet.discover_positions
      dotnet.discover_positions = function(file_path)
        local tree = orig_discover(file_path)
        if not tree then return tree end
        require("nio").scheduler() -- treesitter/vim APIs need the main loop
        local map = method_range_map(file_path)
        for _, node in tree:iter_nodes() do
          local d = node:data()
          if (d.type == "test" or d.type == "namespace") then
            local r = d.range
            if not r or (r[1] == 0 and r[3] == 0) then -- collapsed
              local key = tostring(d.id):match("::method:(.+)$")
              local rng = key and map[key]
              if rng then d.range = rng end
            end
          end
        end
        return tree
      end
    end

    neotest.setup({
      adapters = {
        dotnet, -- .NET (easy-dotnet); needs test_runner.neotest_integration=true in easy-dotnet.lua
        -- require("neotest-jest")({
        --   jestCommand = "npm test --",
        --   jest_test_discovery = true,
        -- }),
        -- require("neotest-vitest"),
        -- require("neotest-python")({
        --   dap = { justMyCode = false },
        -- }),
        -- require("neotest-golang"),
        -- require("neotest-plenary"),
      },
      -- Rider-like results tree
      summary = {
        open = "botright vsplit | vertical resize 50",
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          run = "r",
          debug = "d",
          jumpto = "i",
          output = "o",
          short = "O",
          stop = "u",
          mark = "m",
          run_marked = "R",
          watch = "w",
        },
      },
      output = { open_on_run = false },
      output_panel = { open = "botright split | resize 15" },
      quickfix = { enabled = false, open = false },
      status = { virtual_text = true, signs = true },
      icons = {
        -- passed = "",
        -- failed = "",
        -- running = "",
        -- skipped = "",
        -- unknown = "",
        running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
      },
    })
  end,
  keys = {
    { "<leader>tr", function() require("neotest").run.run() end,                                        desc = "Run test under cursor" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "Run tests in file/class" },
    { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end,                            desc = "Run all tests (project)" },
    { "<leader>tl", function() require("neotest").run.run_last() end,                                   desc = "Run last test" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end,                    desc = "Debug test under cursor" },
    { "<leader>tS", function() require("neotest").run.stop() end,                                       desc = "Stop running test" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,                 desc = "Toggle watch (file)" },
    { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "Toggle summary window" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show test output (float)" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end,                            desc = "Toggle output panel" },
    { "<leader>tj", function() require("neotest").jump.next({ status = "failed" }) end,                 desc = "Jump to next failed test" },
    { "<leader>tk", function() require("neotest").jump.prev({ status = "failed" }) end,                 desc = "Jump to prev failed test" },
  },
}

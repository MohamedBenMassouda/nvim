-- Two save paths, so a write never blocks on a slow formatter:
--   fast path  -- native-binary formatters run synchronously before save
--   slow path  -- LSP-driven formatters run async after save
local lsp_only_ft = {
  cs = true, -- Roslyn
  java = true, -- jdtls
}

-- prettierd is a daemon: node startup is paid once per machine, not per save
local prettier = { "prettierd", "prettier", stop_after_first = true }

local formatters_by_ft = {
  lua = { "stylua" },
  -- ruff covers both steps in one Rust binary; isort's Python startup was
  -- costing more than the formatting itself
  python = { "ruff_organize_imports", "ruff_format" },
  go = { "goimports", "gofumpt" },
  rust = { "rustfmt" },
  sh = { "shfmt" },
  bash = { "shfmt" },
  zsh = { "shfmt" },
  toml = { "taplo" },
}

local uses_prettier = {}
for _, ft in ipairs({
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "jsonc",
  "yaml",
  "markdown",
  "html",
  "css",
  "scss",
  "graphql",
}) do
  formatters_by_ft[ft] = prettier
  uses_prettier[ft] = true
end

local function autoformat_disabled(bufnr)
  return vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat
end

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format File",
    },
    {
      "<leader>cF",
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify("Format on save " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
      end,
      desc = "Toggle Format on Save",
    },
  },
  opts = {
    -- Never round-trip to the LSP unless a filetype opts in below. The old
    -- "fallback" default made every save of an unlisted filetype wait on a
    -- formatting request that usually returned nothing.
    default_format_opts = {
      lsp_format = "never",
      timeout_ms = 500,
    },
    formatters_by_ft = formatters_by_ft,
    format_on_save = function(bufnr)
      if autoformat_disabled(bufnr) then
        return
      end
      local ft = vim.bo[bufnr].filetype
      if lsp_only_ft[ft] then
        return -- handled by format_after_save
      end
      -- Native binaries land in tens of milliseconds; only prettierd's first
      -- save of the session needs more than that, so it gets the longer budget.
      return { timeout_ms = uses_prettier[ft] and 1000 or 500 }
    end,
    format_after_save = function(bufnr)
      if autoformat_disabled(bufnr) or not lsp_only_ft[vim.bo[bufnr].filetype] then
        return
      end
      return { lsp_format = "fallback" }
    end,
  },
}

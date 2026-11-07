-- macOS-only tuning. Loaded from init.lua when sysname == "Darwin".
-- Every workaround here targets a cost that is cheap on Linux, which is why the
-- same config feels fast there.

-- Neovim's LSP file watcher has no fsevents backend. When a server dynamically
-- registers workspace/didChangeWatchedFiles, Neovim walks the workspace and
-- opens a handle per directory -- node_modules and bin/obj turn that into
-- thousands of handles on the first attach. Linux gets inotify and barely
-- notices. ":checkhealth vim.lsp" reports this under "file watching".
vim.lsp.config("*", {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = { dynamicRegistration = false },
    },
  },
})

-- Each provider probe spawns a process at startup. On macOS /usr/bin/python3
-- and /usr/bin/ruby are Xcode command-line-tools shims that can block for
-- seconds when the tools aren't fully installed.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

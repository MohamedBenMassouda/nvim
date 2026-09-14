vim.g.is_mac = vim.uv.os_uname().sysname == "Darwin"

require("config.lazy")
require("config.keymaps")
require("config.options")

if vim.g.is_mac then
  require("config.macos")
end

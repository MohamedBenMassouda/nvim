local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then return end

require("luasnip").filetype_extend("javascriptreact", { "html" })
require("luasnip").filetype_extend("typescriptreact", { "html" })
-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

-- Function to get the package name from the file path
function get_package_name()
	local path = vim.fn.expand "%:p:h" -- Get the full path of the current file's directory
	if string.find(path, "src/main/java") then
		local package_path = string.sub(path, string.find(path, "src/main/java") + 14) -- Extract path after "src/main/java"
		return "package " .. string.gsub(package_path, "/", ".") .. ";" -- Convert path separators to package separators
	end

	local src_index = string.find(path, "/src/")
	if src_index then
		local package_path = string.sub(path, src_index + 5) -- Extract path after "/src/"
		return "package " .. string.gsub(package_path, "/", ".") .. ";" -- Convert path separators to package separators
	else
		return ""
	end
end

local snip = luasnip.snippet
local func = luasnip.function_node

luasnip.add_snippets(nil, {
	java = {
		snip({
			trig = "package",
			namr = "package",
			dscr = "Package declaration for current file",
		}, {
			func(get_package_name, {}),
		}),
	},
})

luasnip.config.set_config {
	history = true,
	enable_autosnippets = true,
}

vim.keymap.set({ "i" }, "<C-K>", function() luasnip.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() luasnip.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() luasnip.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if luasnip.choice_active() then luasnip.change_choice(1) end
end, { silent = true })

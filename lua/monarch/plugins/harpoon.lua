local harpoon = require "harpoon"

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>hm", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>hu", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>&", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>é", function() harpoon:list():select(2) end)
vim.keymap.set("n", '<leader>"', function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>'", function() harpoon:list():select(4) end)

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table {
				results = file_paths,
			},
			previewer = conf.file_previewer {},
			sorter = conf.generic_sorter {},
		})
		:find()
end

local function toggle_fzf_lua(harpoon_files)
	local file_paths = {}

	for _, item in pairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("fzf-lua").fzf_exec(file_paths, {
		prompt = "Harpoon ",
		complete = function(selected, opts, line, col) vim.api.nvim_command("e " .. selected[1]) end,
	})
end

vim.keymap.set("n", "<leader>ht", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })

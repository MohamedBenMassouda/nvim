local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = 0 }

local function insert(opts, desc)
	table.insert(opts, { descr = desc })
end

map("n", "<leader>ge", "<CMD>GoIfErr<CR>", insert(opts, "Adds error handling to the function"))
map("n", "<leader>gt", "<CMD>GoTest<CR>", insert(opts, "Runs the test for the current package"))
map("n", "<leader>gg", "<CMD>GoGet<CR>", insert(opts, 'Runs "go get -u"'))

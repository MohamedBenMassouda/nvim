local function map(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { silent = true, buffer = 0, desc = desc })
end

map("<leader>ge", "<CMD>GoIfErr<CR>", "Adds error handling to the function")
map("<leader>gt", "<CMD>GoTest<CR>", "Runs the test for the current package")
map("<leader>gG", "<CMD>GoGet<CR>", 'Runs "go get -u"')

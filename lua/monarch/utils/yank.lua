local function toggle_telescope()
	local yanks = vim.fn.execute "registers"

	local lines = vim.split(yanks, "\n")

	local yank_history = {}

	-- Skip the first two lines
	for i = 3, #lines do
		local line = lines[i]

		-- Skip empty lines
		if line ~= "" then
			local type, register, text = line:match "^%s*(%a+)%s+(%S+)%s+(.*)$"

			-- Check if valid yank information is present
			if type and register and text then
				-- Replace "^J" with actual line breaks
				local content = vim.fn.substitute(text, "\\^J", "\n", "g")
				content = vim.fn.substitute(content, "\\^M", "\r", "g")
				content = vim.fn.substitute(content, "\\^I", "\t", "g")

				text = vim.fn.substitute(text, "\\^J", "", "g")
				text = vim.fn.substitute(text, "\\^M", "", "g")
				text = vim.fn.substitute(text, "\\^I", "", "g")

				if content ~= "" then
					-- If the content is empty, don't add it to the history
					-- This is useful for the black hole register
					-- For more information see :h quote_

					-- text is the text given by :registers
					-- content is the actual content of the register
					-- for more help see :h registers
					table.insert(yank_history, {
						type = type,
						register = register,
						text = text,
						content = content,
					})
				end
			end
		end
	end

	local conf = require("telescope.config").values
	require("telescope.pickers")
		.new({}, {
			prompt_title = "Yank History",
			finder = require("telescope.finders").new_table {
				results = yank_history,
				entry_maker = function(entry)
					return {
						value = entry,
						register = entry.register,
						content = entry.content,
						display = entry.text,
						ordinal = entry.text,
						preview_command = function(_, bufnr)
							local content = entry.content:match "^%s*(.-)%s*$"
							vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(content, "\n"))
						end,
					}
				end,
			},
			previewer = require("telescope.previewers").display_content.new {},
			sorter = require("telescope.config").values.generic_sorter {},
			attach_mappings = function(_, map)
				require("telescope.actions").select_default:replace(function(prompt_bufnr)
					local entry = require("telescope.actions.state").get_selected_entry()
					require("telescope.actions").close(prompt_bufnr)

					if entry then
						local content = entry.content or "" -- Ensure content is not nil
						local register = entry.register or '"'
						vim.fn.setreg(register, content)
					end
				end)

				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<leader>yy", toggle_telescope, { noremap = true, silent = true })

local dap = require "dap"
local dapui = require "dapui"

require("mason-nvim-dap").setup {
	-- Makes a best effort to setup the various debuggers with
	-- reasonable debug configurations
	automatic_setup = true,

	-- You can provide additional configuration to the handlers,
	-- see mason-nvim-dap README for more information
	handlers = {},

	-- You'll need to check that you have the required things installed
	-- online, please don't ask me how to install them :)
	ensure_installed = {
		-- Update this to ensure that you have the debuggers for the langs you want
		"delve",
	},
}

require("dap-go").setup()

-- Basic debugging keymaps, feel free to change to your liking!
vim.keymap.set("n", "<leader>ds", dap.close, { desc = "Debug: Close" })
vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Debug: Pause" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set(
	"n",
	"<leader>dB",
	function() dap.set_breakpoint(vim.fn.input "Breakpoint condition: ") end,
	{ desc = "Debug: Set Breakpoint" }
)

-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
dapui.setup {
	-- Set icons to characters that are more likely to work in every terminal.
	--    Feel free to remove or use ones that you like more! :)
	--    Don't feel like these are good choices.
	-- icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
	controls = {
		icons = {
			pause = "⏸",
			play = "▶",
			step_into = "",
			step_over = "",
			step_out = "",
			step_back = "",
			run_last = "",
			terminate = "⏹",
			disconnect = "",
		},
	},

	-- layouts = {
	-- 	{
	-- 		elements = {
	-- 			{
	-- 				id = "scopes",
	-- 				size = 0.25,
	-- 			},
	-- 			{
	-- 				id = "breakpoints",
	-- 				size = 0.25,
	-- 			},
	-- 			{
	-- 				id = "stacks",
	-- 				size = 0.25,
	-- 			},
	-- 			{
	-- 				id = "watches",
	-- 				size = 0.25,
	-- 			},
	-- 		},
	-- 		position = "left",
	-- 		size = 40,
	-- 	},
	-- },
}

-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle Dap UI" })

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

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
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

require("nvim-dap-virtual-text").setup {
	enabled = true, -- enable this plugin (the default)
	enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
	highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
	highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
	show_stop_reason = true, -- show stop reason when stopped for exceptions
	commented = false, -- prefix virtual text with comment string
	only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
	all_references = false, -- show virtual text on all all references of the variable (not only definitions)
	clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
	--- A callback that determines how a variable is displayed or whether it should be omitted
	--- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
	--- @param buf number
	--- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
	--- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
	--- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
	--- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
	display_callback = function(variable, buf, stackframe, node, options)
		if options.virt_text_pos == "inline" then
			return " = " .. variable.value
		else
			return variable.name .. " = " .. variable.value
		end
	end,
	-- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
	virt_text_pos = vim.fn.has "nvim-0.10" == 1 and "inline" or "eol",

	-- experimental features:
	all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
	virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
	virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
	-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

dap.adapters.dart = {
	type = "executable",
	command = "dart",
	-- This command was introduced upstream in https://github.com/dart-lang/sdk/commit/b68ccc9a
	args = { "debug_adapter" },
}
dap.configurations.dart = {
	{
		type = "dart",
		request = "launch",
		name = "Launch Dart Program",
		-- The nvim-dap plugin populates this variable with the filename of the current buffer
		program = "${file}",
		-- The nvim-dap plugin populates this variable with the editor's current working directory
		cwd = "${workspaceFolder}",
		args = { "--help" }, -- Note for Dart apps this is args, for Flutter apps toolArgs
	},
}


-- custom adapter for running tasks before starting debug
local custom_adapter = "pwa-node-custom"
dap.adapters[custom_adapter] = function(cb, config)
	if config.preLaunchTask then
		local async = require "plenary.async"
		local notify = require("notify").async

		async.run(function()
			---@diagnostic disable-next-line: missing-parameter
			notify("Running [" .. config.preLaunchTask .. "]").events.close()
		end, function()
			vim.fn.system(config.preLaunchTask)
			config.type = "pwa-node"
			dap.run(config)
		end)
	end
end

-- language config
for _, language in ipairs { "typescript", "javascript" } do
	dap.configurations[language] = {
		{
			name = "Launch",
			type = "pwa-node",
			request = "launch",
			program = "${file}",
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**" },
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			name = "Attach to node process",
			type = "pwa-node",
			request = "attach",
			rootPath = "${workspaceFolder}",
			processId = require("dap.utils").pick_process,
		},
		{
			name = "Debug Main Process (Electron)",
			type = "pwa-node",
			request = "launch",
			program = "${workspaceFolder}/node_modules/.bin/electron",
			args = {
				"${workspaceFolder}/dist/index.js",
			},
			outFiles = {
				"${workspaceFolder}/dist/*.js",
			},
			resolveSourceMapLocations = {
				"${workspaceFolder}/dist/**/*.js",
				"${workspaceFolder}/dist/*.js",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**" },
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			name = "Compile & Debug Main Process (Electron)",
			type = custom_adapter,
			request = "launch",
			preLaunchTask = "npm run build-ts",
			program = "${workspaceFolder}/node_modules/.bin/electron",
			args = {
				"${workspaceFolder}/dist/index.js",
			},
			outFiles = {
				"${workspaceFolder}/dist/*.js",
			},
			resolveSourceMapLocations = {
				"${workspaceFolder}/dist/**/*.js",
				"${workspaceFolder}/dist/*.js",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**" },
			protocol = "inspector",
			console = "integratedTerminal",
		},
	}
end

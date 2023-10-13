local M = {}

function M.catppuccin_cmp_colors()
	local C = require("catppuccin.palettes").get_palette()

	return {
		CmpItemAbbr = { fg = C.overlay2 },
		CmpItemAbbrDeprecated = { fg = C.overlay0, style = { "strikethrough" } },
		CmpItemKind = { fg = C.blue },
		CmpItemMenu = { fg = C.text },
		CmpItemAbbrMatch = { fg = C.text, style = { "bold" } },
		CmpItemAbbrMatchFuzzy = { fg = C.text, style = { "bold" } },

		-- kind support
		CmpItemKindSnippet = { fg = C.mauve },
		CmpItemKindKeyword = { fg = C.red },
		CmpItemKindText = { fg = C.teal },
		CmpItemKindMethod = { fg = C.blue },
		CmpItemKindConstructor = { fg = C.blue },
		CmpItemKindFunction = { fg = C.blue },
		CmpItemKindFolder = { fg = C.blue },
		CmpItemKindModule = { fg = C.blue },
		CmpItemKindConstant = { fg = C.peach },
		CmpItemKindField = { fg = C.green },
		CmpItemKindProperty = { fg = C.green },
		CmpItemKindEnum = { fg = C.green },
		CmpItemKindUnit = { fg = C.green },
		CmpItemKindClass = { fg = C.yellow },
		CmpItemKindVariable = { fg = C.flamingo },
		CmpItemKindFile = { fg = C.blue },
		CmpItemKindInterface = { fg = C.yellow },
		CmpItemKindColor = { fg = C.red },
		CmpItemKindReference = { fg = C.red },
		CmpItemKindEnumMember = { fg = C.red },
		CmpItemKindStruct = { fg = C.blue },
		CmpItemKindValue = { fg = C.peach },
		CmpItemKindEvent = { fg = C.blue },
		CmpItemKindOperator = { fg = C.blue },
		CmpItemKindTypeParameter = { fg = C.blue },
		CmpItemKindCopilot = { fg = C.teal },
	}
end

function M.change_catpuccin_treesitter_colors()
	local C = require("catppuccin.palettes").get_palette()

	return {
		["@variable"] = { fg = C.rosewater },
	}
end

return M

-- Telescope Colors Customization
-- local colors = require("catppuccin.palettes").get_palette()
-- local TelescopeColor = {
--     TelescopeMatching = { fg = colors.flamingo },
--     TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
--
--     TelescopePromptPrefix = { bg = colors.surface0 },
--     TelescopePromptNormal = { bg = colors.surface0 },
--     TelescopeResultsNormal = { bg = colors.mantle },
--     TelescopePreviewNormal = { bg = colors.mantle },
--     TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
--     TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
--     TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
--     TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
--     TelescopeResultsTitle = { fg = colors.mantle },
--     TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
-- }
--
-- for hl, col in pairs(TelescopeColor) do
--     vim.api.nvim_set_hl(0, hl, col)
-- end

local keymaps = require("keymaps.core").keymaps
local vim_keymap_set = require("keymaps.core").vim_keymap_set

return {
	{
		"zbirenbaum/copilot.lua",
		opts = {
			panel = {
				enabled = false,
			},
			suggestion = {
				enabled = true,
				auto_trigger = false,
				keymap = {
					accept = "<Tab>",
				},
			},
			filetypes = {
				yaml = false,
				markdown = true,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
		},
		config = function(_, opts)
			local copilot = require("copilot")
			local copilot_suggestion = require("copilot.suggestion")

			copilot.setup(opts)

			vim_keymap_set(keymaps.toggle_copilot, require("copilot.suggestion").toggle_auto_trigger)

			vim.keymap.set("i", "<M-;>", function()
				if copilot_suggestion.is_visible() then
					copilot_suggestion.toggle_auto_trigger()
					copilot_suggestion.dismiss()
				else
					copilot_suggestion.toggle_auto_trigger()
					copilot_suggestion.next()
				end
			end)
		end,
		cond = function() return not vim.g.vscode end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = true,
		dependencies = { "zbirenbaum/copilot.lua" },
		cond = function() return not vim.g.vscode end,
	},
}

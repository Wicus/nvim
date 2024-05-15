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
				enabled = false, -- This is to work with copilot-cmp.
				auto_trigger = false,
				keymap = {
					accept = false, -- This is for a super tab like behavior, see down below for more details.
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
			vim.keymap.set("i", "<M-;>", function() copilot_suggestion.next() end)

			-- Set <Tab> to accept suggestion if it is visible else use default behavior
			vim.keymap.set("i", "<Tab>", function()
				if copilot_suggestion.is_visible() then
					copilot_suggestion.accept()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end, {
				silent = true,
			})
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

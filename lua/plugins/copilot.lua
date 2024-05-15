local keymaps = require("keymaps.core").keymaps
local vim_keymap_set = require("keymaps.core").vim_keymap_set

return {
	"zbirenbaum/copilot.lua",
	opts = {
		panel = {
			enabled = false,
		},
		suggestion = {
			enabled = true,
			auto_trigger = false,
			keymap = {
				accept = false,
				accept_word = false,
				accept_line = false,
				next = "<C-j>",
				prev = false,
				dismiss = false,
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

		-- Mapping that I'm used to... to be removed later
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
}

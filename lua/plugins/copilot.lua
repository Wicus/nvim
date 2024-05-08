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
			auto_trigger = true,
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
		require("copilot").setup(opts)
		vim_keymap_set(keymaps.toggle_copilot, require("copilot.suggestion").toggle_auto_trigger)
	end,
	cond = function() return not vim.g.vscode end,
}

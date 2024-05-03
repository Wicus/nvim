return {
	{
		"zbirenbaum/copilot.lua",
		opts = {
			panel = {
				enabled = false,
			},
			suggestion = {
				enabled = false,
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
		config = function(_, opts) require("copilot").setup(opts) end,
		cond = function() return not vim.g.vscode end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = true,
		dependencies = { "zbirenbaum/copilot.lua" },
		cond = function() return not vim.g.vscode end,
	},
}

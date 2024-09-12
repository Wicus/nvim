return {
	"jiaoshijie/undotree",
	dependencies = "nvim-lua/plenary.nvim",
	keys = {
		{ "<leader>ut", function() require("undotree").toggle() end, { desc = "Undo tree" } },
	},
	opts = {
		float_diff = true, -- using float window previews diff, set this `true` will disable layout option
		layout = "left_bottom", -- "left_bottom", "left_left_bottom"
		position = "left", -- "right", "bottom"
		ignore_filetype = { "undotree", "undotreeDiff", "qf", "TelescopePrompt", "spectre_panel", "tsplayground" },
		window = {
			winblend = 0,
		},
	},
	cond = function() return not vim.g.vscode end,
}

return {
	"jiaoshijie/undotree",
	dependencies = "nvim-lua/plenary.nvim",
	config = true,
	keys = {
		{ "<leader>ut", function() require("undotree").toggle() end, { desc = "Undo tree" } },
	},
	cond = function() return not vim.g.vscode end,
}

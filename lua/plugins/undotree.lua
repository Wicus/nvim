return {
	"mbbill/undotree",
	keys = {
		{
			"<leader>u",
			vim.cmd.UndotreeToggle,
			{ desc = "Undo tree toggle" },
		},
	},
	config = function() vim.g.undotree_SetFocusWhenToggle = 1 end,
}

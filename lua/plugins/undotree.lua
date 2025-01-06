return {
	"mbbill/undotree",
	keys = {
		{ "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
	},
	config = function() vim.g.undotree_SplitWidth = 79 end,
}

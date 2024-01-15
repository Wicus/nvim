return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "Undo tree" })
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
}

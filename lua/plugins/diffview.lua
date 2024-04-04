return {
	"sindrets/diffview.nvim",
	config = function()
		require("diffview").setup()

		vim.keymap.set("n", "<leader>gss", "<cmd>DiffviewOpen<CR>")
		vim.keymap.set("n", "<leader>gsc", "<cmd>DiffviewClose<CR>")
	end,
	cond = function() return not vim.g.vscode end,
}

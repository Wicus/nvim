return {
	"sindrets/diffview.nvim",
	opts = {
		keymaps = {
			view = {
				-- The `view` bindings are active in the diff buffers, only when the current tabpage is a Diffview.
				{ "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close" } },
			},
		},
	},
	config = function(_, opts)
		require("diffview").setup(opts)

		vim.keymap.set("n", "<leader>gs", "<cmd>DiffviewOpen<CR>")
	end,
	cond = function() return not vim.g.vscode end,
}

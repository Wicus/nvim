return {
	"sindrets/diffview.nvim",
	opts = {
		keymaps = {
			view = {
				-- The `view` bindings are active in the diff buffers, only when the current tabpage is a Diffview.
				{ "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close" } },
			},
			diff1 = {},
			diff2 = {},
			diff3 = {},
			diff4 = {},
			file_panel = {
				{ "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close" } },
			},
			file_history_panel = {
				{ "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close" } },
			},
			option_panel = {
				{ "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close" } },
			},
			help_panel = {},
		},
	},
	config = function(_, opts)
		require("diffview").setup(opts)

		vim.keymap.set("n", "<leader>gs", "<cmd>DiffviewOpen<CR>", { desc = "Git Diff" })
		vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<CR>", { desc = "Git File History" })
	end,
	cond = function() return not vim.g.vscode end,
}

return {
	"robitx/gp.nvim",
	opts = {
		chat_user_prefix = "󰙃 :",
		chat_assistant_prefix = { " : ", "[{{agent}}]" },
		command_prompt_prefix_template = "{{agent}}",
	},
	config = function(_, opts)
		require("gp").setup(opts)

		vim.keymap.set("n", "<leader>ch", "<cmd>GpChatToggle<cr>", { desc = "Toggle chat" })
	end,
}

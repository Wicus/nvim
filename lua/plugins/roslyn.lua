return {
	"seblj/roslyn.nvim",
	ft = "cs",
	opts = {
		filewatching = "roslyn",
	},
    keys = {
        { "<leader>rt", "<cmd>Roslyn target<cr>", desc = "Roslyn Select Target" },
        { "<leader>rs", "<cmd>Roslyn stop<cr>", desc = "Roslyn Stop" },
        { "<leader>rr", "<cmd>Roslyn restart<cr>", desc = "Roslyn Restart" },
    }
}

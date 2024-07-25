return {
	"fnune/recall.nvim",
	version = "*",
	config = function()
		local recall = require("recall")

		recall.setup({ sign = "" })

		vim.keymap.set("n", "<leader>mm", recall.toggle, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>mc", recall.clear, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>ml", ":Telescope recall<CR>", { noremap = true, silent = true })
	end,
}

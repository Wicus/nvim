return {
	"folke/flash.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local flash = require("flash")

		vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash jump" })
		vim.keymap.set("n", "<leader>ts", flash.toggle, { desc = "Toggle flash" })
	end,
}

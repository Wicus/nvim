return {
	"folke/flash.nvim",
	-- event = { "BufReadPre", "BufNewFile" },
	config = function()
		local flash = require("flash")

		vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash jump" })
		vim.keymap.set("n", "<leader>uf", flash.toggle, { desc = "Flash" })
	end,
}

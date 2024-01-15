return {
	"ThePrimeagen/harpoon",
	opts = {
		menu = {
			borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			-- width = vim.api.nvim_win_get_width(0) - 140,
		},
	},
	keys = {
		{ "<leader>fa", function() require("harpoon.mark").add_file() end, { desc = "Harpoon add file" } },
		{ "<leader>0", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Harpoon quick menu" } },
		{ "<leader>1", function() require("harpoon.ui").nav_file(1) end, { desc = "Harpoon file 1" } },
		{ "<leader>2", function() require("harpoon.ui").nav_file(2) end, { desc = "Harpoon file 2" } },
		{ "<leader>3", function() require("harpoon.ui").nav_file(3) end, { desc = "Harpoon file 3" } },
		{ "<leader>4", function() require("harpoon.ui").nav_file(4) end, { desc = "Harpoon file 4" } },
		{ "<leader>5", function() require("harpoon.ui").nav_file(5) end, { desc = "Harpoon file 5" } },
	},
	cond = function() return not vim.g.vscode end,
}

return {
	"folke/which-key.nvim",
	config = function()
		vim.opt.timeout = true
		vim.opt.timeoutlen = 300

		local which_key = require("which-key")
		which_key.setup({
			plugins = {
				registers = false,
			},
		})
		which_key.register({
			["<leader>u"] = {
				name = "Toggle",
			},
		})
	end,
	cond = function() return not vim.g.vscode end,
}

return {
	"folke/which-key.nvim",
	config = function()
		vim.opt.timeout = true
		vim.opt.timeoutlen = 300

		local which_key = require("which-key")
		which_key.setup({
			preset = "classic",
			plugins = {
				registers = false,
			},
			notify = false,
			icons = {
				mappings = false,
			},
		})
	end,
	cond = function() return not vim.g.vscode end,
}

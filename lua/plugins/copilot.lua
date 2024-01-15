return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_filetypes = { TelescopePrompt = false, text = false, markdown = true }
		vim.g.copilot_assume_mapped = true
	end,
	cond = function() return not vim.g.vscode end,
}

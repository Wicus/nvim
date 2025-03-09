-- TODO: Remove once the new PR is in:
-- https://github.com/seblyng/roslyn.nvim/pull/163
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

return {
	"seblj/roslyn.nvim",
	ft = "cs",
	opts = {
		config = {
			capabilities = capabilities,
		},
	},
}

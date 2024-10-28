return {
	"seblj/roslyn.nvim",
	ft = "cs",
	opts = {},
	config = function(_, opts)
		require("roslyn").setup(opts)
		require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		local telescope_builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>dw", telescope_builtin.diagnostics, { desc = "Diagnostics in telescope" })
		vim.keymap.set("n", "<leader>uh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle inlay hints" })

		local utils = require("utils")
		utils.lsp_config_on_attach()
	end,
}

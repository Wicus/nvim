return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
		{ "saghen/blink.cmp" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("blink-cmp").get_lsp_capabilities()
		local config = {
			capabilities = capabilities,
		}

		lspconfig.lua_ls.setup(config)
		lspconfig.eslint.setup(config)
		lspconfig.clangd.setup(config)
		lspconfig.pyright.setup(config)
		lspconfig.jsonls.setup(config)
		lspconfig.intelephense.setup(config)
		lspconfig.html.setup(config)
		lspconfig.cssls.setup(config)
		lspconfig.lemminx.setup(config)
		lspconfig.astro.setup(config)
		lspconfig.tailwindcss.setup(config)

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("LspAttachGroup", { clear = true }),
			callback = function()
				-- "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
				-- "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
				-- "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
				-- "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
				-- "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
				-- CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|
				vim.keymap.set("n", "grr", "<cmd>FzfLua lsp_references<cr>")
				vim.keymap.set("n", "gri", "<cmd>FzfLua lsp_implementations<cr>")
				vim.keymap.set("n", "grt", "<cmd>FzfLua lsp_typedefs<cr>")
				vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>")
				vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help)
			end,
		})
	end,
}

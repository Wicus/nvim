return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "folke/lazydev.nvim", opts = {} },
		{ "saghen/blink.cmp" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("blink-cmp").get_lsp_capabilities()
		local config = {
			capabilities = capabilities,
		}

		lspconfig.lua_ls.setup(config)
		lspconfig.clangd.setup(config)
		lspconfig.pyright.setup(config)
		lspconfig.jsonls.setup(config)
		lspconfig.intelephense.setup(config)
		lspconfig.html.setup(config)
		lspconfig.cssls.setup(config)
		lspconfig.lemminx.setup(config)
		lspconfig.astro.setup(config)
		lspconfig.tailwindcss.setup(config)

		vim.lsp.config["ts_ls"] = {
			vim.tbl_deep_extend("force", config, {
				vtsls = {
					-- explicitly add default filetypes, so that we can extend
					-- them in related extras
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {
						complete_function_calls = true,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								maxInlayHintLength = 30,
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = {
								completeFunctionCalls = true,
							},
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
							},
						},
					},
				},
			}),
		}

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("LspAttachGroup", { clear = true }),
			callback = function()
				-- "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
				-- "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
				-- "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
				-- "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
				-- "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
				-- CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|
				vim.keymap.set("n", "grr", function() Snacks.picker.lsp_references() end)
				vim.keymap.set("n", "gri", function() Snacks.picker.lsp_implementations() end)
				vim.keymap.set("n", "grt", function() Snacks.picker.lsp_type_definitions() end)
				vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end)
				vim.keymap.set("n", "gh", vim.diagnostic.open_float)
				vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help)
			end,
		})
	end,
}

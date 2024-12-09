return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"Hoffs/omnisharp-extended-lsp.nvim",
		"Issafalcon/lsp-overloads.nvim",
		{ "folke/neodev.nvim", config = true },
		{ "j-hui/fidget.nvim", config = true },
	},
	config = function()
		-- Set border for floating windows
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers["textDocument/hover"], { border = "single" })
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["textDocument/signatureHelp"], { border = "single" })
		vim.diagnostic.config({
			float = { border = "single" },
			underline = {
				severity = { min = vim.diagnostic.severity.WARN },
			},
			virtual_text = {
				severity = { min = vim.diagnostic.severity.ERROR },
			},
			signs = {
				severity = { min = vim.diagnostic.severity.ERROR },
			},
		})

		require("mason").setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:crashdummyy/mason-registry",
			},
		})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"eslint",
				"clangd",
				"pyright",
				"omnisharp",
				"jsonls",
				"intelephense",
				"html",
				"cssls",
				"tailwindcss",
				"lemminx",
				"astro",
			},
		})
		require("mason-tool-installer").setup({
			ensure_installed = {
				"stylua",
				"prettierd",
				"prettier",
				"clang-format",
				"black",
				"csharpier",
				"roslyn",
			},
		})

		local lspconfig = require("lspconfig")
		local utils = require("utils")
		local config = {
			capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			on_attach = utils.lsp_config_on_attach,
		}
		local config_with_opts = function(settings) return vim.tbl_deep_extend("force", config, settings) end
		lspconfig.ts_ls.setup(config)
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
		lspconfig.omnisharp.setup(config_with_opts({
			on_attach = function(client, bufnr)
				config.on_attach(client, bufnr)
				vim.keymap.set("n", "gd", require("omnisharp_extended").telescope_lsp_definition, { desc = "[G]oto [D]efinition" })
				vim.keymap.set("n", "gr", require("omnisharp_extended").telescope_lsp_references, { desc = "[G]oto [R]eferences" })
				vim.keymap.set("n", "gi", require("omnisharp_extended").telescope_lsp_implementation, { desc = "Goto to type implementations" })
				vim.keymap.set("n", "gt", require("omnisharp_extended").telescope_lsp_type_definition, { desc = "[G]oto [T]ype definition" })

				-- lsp-overloads
				if client.server_capabilities.signatureHelpProvider then
					require("lsp-overloads").setup(client, {
						keymaps = {
							next_signature = "<C-d>",
							previous_signature = "<C-u>",
							next_parameter = nil,
							previous_parameter = nil,
							close_signature = nil,
						},
					})
				end
			end,
		}))
		lspconfig.lua_ls.setup(config_with_opts({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		}))
	end,
	cond = function() return not vim.g.vscode end,
}

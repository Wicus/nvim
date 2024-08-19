return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"Hoffs/omnisharp-extended-lsp.nvim",
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

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"tsserver",
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
			},
		})

		local lspconfig = require("lspconfig")
		local telescope_builtin = require("telescope.builtin")
		local config = {
			capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			on_attach = function(client, bufnr)
				vim.keymap.set("n", "cn", vim.lsp.buf.rename, { desc = "[C]hange [N]ame (Rename)" })
				vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })
				vim.keymap.set("n", "gr", telescope_builtin.lsp_references, { desc = "[G]oto [R]eferences" })
				vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, { desc = "Goto to type implementations" })
				vim.keymap.set("n", "gt", telescope_builtin.lsp_type_definitions, { desc = "[G]oto [T]ype definition" })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
				vim.keymap.set("n", "<M-w>", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" }) -- <M-w> is remapped to <C-.> in AutoHotKey
				vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" }) -- This is for other terminal emulators
			end,
		}
		local config_with_opts = function(settings) return vim.tbl_deep_extend("force", config, settings) end
		lspconfig.tsserver.setup(config)
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
		lspconfig.omnisharp.setup(config_with_opts({
			on_attach = function(client, bufnr)
				config.on_attach(client, bufnr)
				vim.keymap.set("n", "gd", require("omnisharp_extended").telescope_lsp_definition, { desc = "[G]oto [D]efinition" })
				vim.keymap.set("n", "gr", require("omnisharp_extended").telescope_lsp_references, { desc = "[G]oto [R]eferences" })
				vim.keymap.set("n", "gi", require("omnisharp_extended").telescope_lsp_implementation, { desc = "Goto to type implementations" })
				vim.keymap.set("n", "gt", require("omnisharp_extended").telescope_lsp_type_definition, { desc = "[G]oto [T]ype definition" })
			end,
		}))
	end,
	cond = function() return not vim.g.vscode end,
}

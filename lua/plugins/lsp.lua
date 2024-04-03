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
				"omnisharp@v1.39.8",
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
				"clang-format",
			},
		})

		local lspconfig = require("lspconfig")
		local config = {
			capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			on_attach = function(client, bufnr)
				-- Has a AutoHotKey script to change this to <C-.> for windows
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
				vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
				vim.keymap.set("n", "cn", vim.lsp.buf.rename, { desc = "[C]hange [N]ame (Rename)" })
				vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "[G]oto [D]efinition" })
				vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
				vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, { desc = "Goto to type implementations" })
				vim.keymap.set("n", "gt", require("telescope.builtin").lsp_type_definitions, { desc = "[G]oto [T]ype definition" })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

				-- Omnisharp overrides
				if client.name == "omnisharp" then
					vim.keymap.set("n", "gd", require("omnisharp_extended").telescope_lsp_definitions, { desc = "[G]oto [D]efinition" })
				end
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
			cmd = { "cmd", "/c", "omnisharp" },
			handlers = { ["textDocument/definition"] = require("omnisharp_extended").handler },
		}))
	end,
	cond = function() return not vim.g.vscode end,
}

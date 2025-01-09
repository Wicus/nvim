return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function(_, opts)
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
				"black",
				"csharpier",
				{ "roslyn", version = "4.14.0-2.25078.5" },
				"sqlfluff",
				"sql-formatter",
			},
		})
	end,
}

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
        -- "jay-babu/mason-nvim-dap.nvim",
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
				"roslyn",
				"sqlfluff",
				"sql-formatter",
				"eslint_d",
			},
		})
        -- TODO: Needs testing
        -- require("mason-nvim-dap").setup({
        --     automatic_installation = true,
        --     handlers = {}, -- You can provide additional configuration to the handlers
        --     ensure_installed = {
        --         -- "debugpy",
        --         -- "netcoredbg",
        --     },
        -- })
	end,
}

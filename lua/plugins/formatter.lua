return {
	"mhartington/formatter.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- Formatter setup
		require("formatter").setup({
			filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				javascript = { require("formatter.filetypes.javascript").prettierd },
				javascriptreact = { require("formatter.filetypes.javascriptreact").prettierd },
				typescript = { require("formatter.filetypes.typescript").prettierd },
				typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
				astro = { require("formatter.filetypes.html").prettier },
				h = { require("formatter.defaults").clangformat },
				c = { require("formatter.defaults").clangformat },
				cpp = { require("formatter.defaults").clangformat },
				hpp = { require("formatter.defaults").clangformat },
				cs = vim.lsp.buf.format,
				python = vim.lsp.buf.format,
				json = { require("formatter.filetypes.json").prettierd },
				xml = vim.lsp.buf.format,
			},
		})

		-- Format on save autocommand
		local formatting_group = vim.api.nvim_create_augroup("format", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			command = "FormatWriteLock",
			group = formatting_group,
			pattern = {
				"*.tsx",
				"*.ts",
				"*.jsx",
				"*.js",
				"*.lua",
				-- "*.cs",
				-- "*.cpp",
				-- "*.hpp",
				"*.json",
				"*.astro",
			},
		})

		vim.keymap.set({ "v" }, "<leader>=", ":Format<cr>", { desc = "Format" })
		vim.keymap.set({ "n" }, "<leader>f=", "<cmd>FormatWriteLock<cr>", { desc = "Format" })
		vim.keymap.set({ "n", "v" }, "<leader>u=", "<cmd>autocmd! format<cr>", { desc = "Toggle format on save" })
	end,
	cond = function() return not vim.g.vscode end,
}

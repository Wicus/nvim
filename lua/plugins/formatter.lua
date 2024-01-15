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
				typescriptreact = { require("formatter.filetypes.typescriptreact").prettierd },
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
		local formatting_group = vim.api.nvim_create_augroup("fomat", { clear = true })
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
				-- "*.json",
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>cf", "<cmd>FormatWriteLock<cr>", { desc = "Format current file" })
	end,
	cond = function() return not vim.g.vscode end,
}

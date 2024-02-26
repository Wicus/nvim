local patch_clangformat_bug = function(f)
	local o = f()
	if o.args and type(o.args) == "table" then
		local new_args = {}
		local skip = false
		for i, v in ipairs(o.args) do
			if skip then
				skip = false
			elseif v == "-assume-filename" and (o.args[i + 1] == "''" or o.args[i + 1] == '""') then
				skip = true
			elseif type(v) ~= "string" or not v:find("^-style=") then
				table.insert(new_args, v)
			end
		end
		o.args = new_args
	end
	return o
end

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
				h = { patch_clangformat_bug(require("formatter.defaults").clangformat) },
				c = { patch_clangformat_bug(require("formatter.defaults").clangformat) },
				cpp = { patch_clangformat_bug(require("formatter.defaults").clangformat) },
				hpp = { patch_clangformat_bug(require("formatter.defaults").clangformat) },
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
				-- "*.json",
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>cf", "<cmd>FormatWriteLock<cr>", { desc = "Format current file" })
		vim.keymap.set({ "n", "v" }, "<leader>u=", "<cmd>autocmd! format<cr>", { desc = "Toggle format on save" })
	end,
	cond = function() return not vim.g.vscode end,
}

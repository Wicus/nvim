-- Highlight on yank
local highlight_group = vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			timeout = 40,
		})
	end,
	pattern = "*",
})

-- Auto bootstrap C# namespace and class name
local csharp_auto_bootstrap_empty_file_group = vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	group = vim.api.nvim_create_augroup("CSharpAutoBootstrapEmptyFile", { clear = true }),
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		require("custom.bootstrap_csharp").bootstrap_empty_file(bufnr)
	end,
	pattern = "*.cs",
})

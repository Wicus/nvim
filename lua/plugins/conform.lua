return {
	"stevearc/conform.nvim",
	lazy = false,
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			cs = { "csharpier" },
			sql = { "sqlfluff" },
			json = { "prettierd" },
		},
	},
	keys = {
		{ "<leader>f=", function() require("conform").format() end, mode = { "n", "v" }, desc = "Format" },
	},
	config = function(_, opts)
		require("conform").setup(opts)

		local function format_on_save()
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				group = vim.api.nvim_create_augroup("FormatOnSaveGroup", { clear = true }),
				callback = function(args) require("conform").format({ bufnr = args.buf }) end,
			})
		end

		local format_on_save_enabled = false
		if format_on_save_enabled then
			format_on_save()
		end
		local function toggle_format_on_save()
			format_on_save_enabled = not format_on_save_enabled
			if format_on_save_enabled then
				format_on_save()
				vim.notify("Format on save enabled", "warn")
			else
				vim.api.nvim_del_augroup_by_name("FormatOnSaveGroup")
				vim.notify("Format on save disabled", "warn")
			end
		end

		vim.keymap.set("n", "<leader>ut", toggle_format_on_save, { desc = "Format on save" })
	end,
}

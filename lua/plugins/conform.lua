return {
	"stevearc/conform.nvim",
	lazy = false,
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			cs = { "csharpier" },
			json = { "prettierd" },
			python = { "black" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
		},
	},
	keys = {
		{ "<leader>f=", function() require("conform").format({ timeout_ms = 5000 }) end, mode = { "n", "v" }, desc = "Format" },
	},
	config = function(_, opts)
		require("conform").setup(opts)

		vim.g.wp_format_on_save = function(is_enabled)
			if is_enabled then
				vim.api.nvim_create_autocmd("BufWritePre", {
					pattern = "*",
					group = vim.api.nvim_create_augroup("FormatOnSaveGroup", { clear = true }),
					callback = function(args) require("conform").format({ bufnr = args.buf, timeout_ms = 5000 }) end,
				})
				vim.notify("Format on save enabled", "warn")
			else
				vim.api.nvim_del_augroup_by_name("FormatOnSaveGroup")
				vim.notify("Format on save disabled", "warn")
			end
		end

		local is_enabled = false
		local function toggle_format_on_save()
			is_enabled = not is_enabled
			vim.g.wp_format_on_save(is_enabled)
		end

		vim.keymap.set("n", "<leader>ut", toggle_format_on_save, { desc = "Format on save" })
	end,
}

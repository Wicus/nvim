return {
	{ "tpope/vim-dadbod", cmd = "DB" },
	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = "vim-dadbod",
		ft = "sql",
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		dependencies = "vim-dadbod",
		init = function()
			vim.g.db_ui_winwidth = 80
			vim.g.db_ui_execute_on_save = false

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("DBUIKeymaps", { clear = true }),
				pattern = "sql",
				callback = function() vim.keymap.set("n", "<F5>", "<Plug>(DBUI_ExecuteQuery)") end,
			})
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = "kristijanhusak/vim-dadbod-completion",
		opts = {
			sources = {
				default = { "dadbod" },
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},
		},
	},
}

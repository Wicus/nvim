return {
	{ "tpope/vim-dadbod", cmd = "DB" },
	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = "vim-dadbod",
		ft = "sql",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "sql",
				callback = function()
					local cmp = require("cmp")
					cmp.setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
							{ name = "buffer" },
						},
					})
				end,
			})
		end,
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
}

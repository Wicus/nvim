local is_windows = string.lower(vim.loop.os_uname().sysname) == "windows_nt"

return {
	"stevearc/oil.nvim",
	keys = { { "-", function() require("oil.actions").parent.callback() end, desc = "Open oil in current working directory" } },
	opts = {
		keymaps = {
			["q"] = "actions.close",
			["g-"] = function()
				if is_windows then
					require("oil.actions").tcd.callback()
					vim.cmd("silent !explorer .")
				end
			end,
			["<C-p>"] = false,
		},
		columns = {},
	},
}

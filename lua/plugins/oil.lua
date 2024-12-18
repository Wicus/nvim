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
			["?"] = "actions.show_help",
			["gy"] = "actions.copy_entry_path",

			-- Overwrite the defaults
			["<CR>"] = "actions.select",
			["<C-s>"] = false,
			["<C-h>"] = false,
			["<C-t>"] = false,
			["<C-p>"] = false,
			["<C-c>"] = false,
			["<C-l>"] = false,
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gs"] = false,
			["gx"] = false,
			["g."] = "actions.toggle_hidden",
			["g\\"] = false,
		},
		-- columns = {},
	},
	cond = function() return not vim.g.vscode end,
}

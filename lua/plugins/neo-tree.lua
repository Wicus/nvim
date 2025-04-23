return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
    lazy = false,
	cmd = "Neotree",
	keys = {
		{
			"<leader>fe",
			function() require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() }) end,
			desc = "Explorer NeoTree (cwd)",
		},
		{
			"<leader>ge",
			function() require("neo-tree.command").execute({ source = "git_status", toggle = true }) end,
			desc = "Git Explorer",
		},
		{
			"<leader>be",
			function() require("neo-tree.command").execute({ source = "buffers", toggle = true }) end,
			desc = "Buffer Explorer",
		},
		{
			"<leader>se",
			function() require("neo-tree.command").execute({ source = "document_symbols", toggle = true }) end,
			desc = "Symbols Explorer",
		},
	},
	opts = {
        close_if_last_window = true,
		sources = { "filesystem", "buffers", "git_status" },
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
		},
		window = {
			position = "left",
			width = 81,
		},
		default_component_configs = {
			container = {
				enable_character_fade = true,
			},
			git_status = {
				symbols = {
					-- Change type
					added = "", -- or "Γ£Ü", but this is redundant info if you use git_status_colors on the name
					modified = "", -- or "∩æä", but this is redundant info if you use git_status_colors on the name
					deleted = "", -- this can only be used in the git_status source
					renamed = "", -- this can only be used in the git_status source
					-- Status type
					untracked = "",
					ignored = "",
					unstaged = "",
					staged = "",
					conflict = "",
				},
			},
			file_size = {
				enabled = true,
			},
			type = {
				enabled = false,
			},
			last_modified = {
				enabled = false,
			},
			created = {
				enabled = false,
			},
			symlink_target = {
				enabled = false,
			},
		},
	},
}

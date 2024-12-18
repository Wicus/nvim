return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{
			"<leader>fE",
			function() require("neo-tree.command").execute({ toggle = true }) end,
			desc = "Explorer NeoTree (Root Dir)",
		},
		{
			"<leader>fe",
			function() require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() }) end,
			desc = "Explorer NeoTree (cwd)",
		},
		{ "<leader>e", "<leader>fE", desc = "Explorer NeoTree (Root Dir)", remap = true },
		{ "<leader>E", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
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
	},
	opts = {
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
	},
}

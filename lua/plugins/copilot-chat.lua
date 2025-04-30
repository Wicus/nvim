return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "main",
	dependencies = {
		"zbirenbaum/copilot.lua",
		"nvim-lua/plenary.nvim",
	},
	cmd = "CopilotChat",
	opts = {
		auto_insert_mode = false,
        -- model = 'o4-mini',
		window = {
			layout = "float",
			relative = "editor",
			width = 0.6,
			height = 0.8,
			zindex = 40,
		},
	},
	keys = {
		{ "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
		{ "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
		{
			"<leader>aa",
			function() return require("CopilotChat").toggle() end,
			desc = "Toggle (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>ax",
			function() return require("CopilotChat").reset() end,
			desc = "Clear (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>aq",
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input)
				end
			end,
			desc = "Quick Chat (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>ap",
			function() require("CopilotChat").select_prompt() end,
			desc = "Prompt Actions (CopilotChat)",
			mode = { "n", "v" },
		},
	},
	config = function(_, opts)
		local chat = require("CopilotChat")

		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "copilot-chat",
			callback = function()
				vim.opt_local.relativenumber = false
				vim.opt_local.number = false
			end,
		})

		chat.setup(opts)
	end,
}

return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "canary",
	dependencies = {
		{ "github/copilot.vim" }, -- or { "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	},
	opts = {
		auto_follow_cursor = false, -- Don't follow the cursor after getting response
		-- default window options
		window = {
			layout = "float", -- 'vertical', 'horizontal', 'float'
			-- Options below only apply to floating windows
			relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
			border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
			width = 0.6, -- fractional width of parent
			height = 0.8, -- fractional height of parent
			row = nil, -- row position of the window, default is centered
			col = nil, -- column position of the window, default is centered
			title = "Copilot Chat", -- title of chat window
			footer = nil, -- footer of chat window
			zindex = 1, -- determines if window is on top or below other floating windows
		},
		mappings = {
			-- Use tab for completion
			complete = {
				insert = "<C-l><C-l>",
			},
			-- Reset the chat buffer
			reset = {
				normal = "<leader>ccr",
				insert = "<C-c>",
			},
		},
	},
	event = "VeryLazy",
	keys = {
		-- Show help actions with telescope
		{
			"<leader>cch",
			function()
				local actions = require("CopilotChat.actions")
				require("CopilotChat.integrations.telescope").pick(actions.help_actions())
			end,
			desc = "CopilotChat - Help actions",
		},
		-- Show prompts actions with telescope
		{
			"<leader>ccp",
			function()
				local actions = require("CopilotChat.actions")
				require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
			end,
			desc = "CopilotChat - Prompt actions",
		},
		-- Custom input for CopilotChat
		{
			"<leader>cci",
			function()
				local input = vim.fn.input("Quick chat with selection: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").unnamed })
				end
			end,
			desc = "CopilotChat - Quick chat with selection",
		},
		-- Quick chat with Copilot
		{
			"<leader>ccb",
			function()
				local input = vim.fn.input("Quick chat with buffer: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end,
			desc = "CopilotChat - Quick chat with buffer",
		},
		{ "<leader>ccl", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
		{ "<leader>ch", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle chat" },
	},
}

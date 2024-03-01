-- NOTE: If you are using Windows, you need to update the rplugin.vim file inside the nvim-data directory.
-- " python3 plugins
-- let nvim_data_dir = $LOCALAPPDATA . "/nvim-data"
-- let copilot_chat_dir = nvim_data_dir . "/lazy/CopilotChat.nvim"
-- let rplugin_python3_dir = copilot_chat_dir . "/rplugin/python3/"
-- let replaceFrontslashes = substitute(rplugin_python3_dir, '/', '\\', 'g')
-- let escapeBackslashes = substitute(replaceFrontslashes, '\\', '\\\\\\\\', 'g')
-- call remote#host#RegisterPlugin('python3', escapeBackslashes . 'CopilotChat', [
--       \ {'sync': v:false, 'name': 'CopilotChat', 'type': 'command', 'opts': {'nargs': '1'}},
--       \ {'sync': v:false, 'name': 'CopilotChatReset', 'type': 'command', 'opts': {}},
--       \ {'sync': v:false, 'name': 'CopilotChatVisual', 'type': 'command', 'opts': {'nargs': '1', 'range': ''}},
--       \ {'sync': v:false, 'name': 'CopilotChatVsplitToggle', 'type': 'command', 'opts': {}},
--       \ {'sync': v:false, 'name': 'CopilotChatInPlace', 'type': 'command', 'opts': {'nargs': '*', 'range': ''}},
--       \ {'sync': v:false, 'name': 'CopilotChatAutocmd', 'type': 'command', 'opts': {'nargs': '*'}},
--       \ {'sync': v:false, 'name': 'CopilotChatMapping', 'type': 'command', 'opts': {'nargs': '*'}},
--      \ ])

return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		opts = {
			show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
			debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
			disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
			language = "English", -- Copilot answer language settings when using default prompts. Default language is English.
			-- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
			-- temperatur= 0.1,
		},
		event = "VeryLazy",
		keys = {
			{ "<leader>cch", ":CopilotChat ", desc = "CopilotChat - Chat with yanked text" },
			{
				"<leader>cch",
				":CopilotChatVisual ",
				mode = "x",
				desc = "CopilotChat - Open in vertical split",
			},
			{ "<leader>ccb", ":CopilotChatBuffer ", desc = "CopilotChat - Chat in buffer" },
			{
				"<leader>ucc",
				"<cmd>CopilotChatVsplitToggle<cr>",
				desc = "Toggle CopilotChat in vertical split",
			},
			{
				"<leader>ccl",
				"<cmd>CopilotChatInPlace<cr>",
				mode = "x",
				desc = "CopilotChat - Run in-place code",
			},
			{
				"<leader>ccf",
				"<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
				desc = "CopilotChat - Fix diagnostic",
			},
			{
				"<leader>ccr",
				"<cmd>CopilotChatReset<cr>", -- Reset chat history and clear buffer.
				desc = "CopilotChat - Reset chat history and clear buffer",
			},
		},
	},
}

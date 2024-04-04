return {
	"robitx/gp.nvim",
	opts = {
		chat_user_prefix = "󰙃 :",
		chat_assistant_prefix = { " : ", "[{{agent}}]" },
		command_prompt_prefix_template = "{{agent}}",
		hooks = {
			-- your own functions can go here, see README for more examples like
			-- :GpExplain, :GpUnitTests.., :GpTranslator etc.

			-- -- example of making :%GpChatNew a dedicated command which
			-- -- opens new chat with the entire current buffer as a context
			-- BufferChatNew = function(gp, _)
			-- 	-- call GpChatNew command in range mode on whole buffer
			-- 	vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
			-- end,

			-- -- example of adding command which opens new chat dedicated for translation
			-- Translator = function(gp, params)
			-- 	local agent = gp.get_command_agent()
			-- 	local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
			-- 	gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
			-- end,

			-- -- example of adding command which writes unit tests for the selected code
			-- UnitTests = function(gp, params)
			-- 	local template = "I have the following code from {{filename}}:\n\n"
			-- 		.. "```{{filetype}}\n{{selection}}\n```\n\n"
			-- 		.. "Please respond by writing table driven unit tests for the code above."
			-- 	local agent = gp.get_command_agent()
			-- 	gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
			-- end,

			-- example of adding command which explains the selected code
			Explain = function(gp, params)
				local template = "I have the following code from {{filename}}:\n\n"
					.. "```{{filetype}}\n{{selection}}\n```\n\n"
					.. "Please respond by explaining the code above. Be very concise. "
				local agent = gp.get_chat_agent()
				gp.Prompt(params, gp.Target.vnew, nil, agent.model, template, agent.system_prompt)
			end,
		},
	},
	config = function(_, opts)
		-- require("gp").setup(opts)
		--
		-- local keymaps = require("keymaps.core").keymaps
		-- local vim_keymap_set = require("keymaps.core").vim_keymap_set
		-- vim_keymap_set(keymaps.chat, "<cmd>GpChatNew<cr>")
		-- vim_keymap_set(keymaps.chat_list, "<cmd>GpChatFinder<cr>")
	end,
	cond = function() return not vim.g.vscode end,
}

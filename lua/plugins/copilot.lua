return {
	"zbirenbaum/copilot.lua",
	opts = {
		suggestion = { auto_trigger = true },
	},
	config = function(_, opts)
		require("copilot").setup(opts)

		vim.keymap.set("n", "<leader>uc", require("copilot.suggestion").toggle_auto_trigger, { desc = "Copilot" })

		vim.api.nvim_create_autocmd("InsertEnter", {
			group = vim.api.nvim_create_augroup("CopilotInsertHideGroup", { clear = true }),
			callback = function() vim.b.copilot_suggestion_hidden = true end,
			desc = "Hide copilot suggestion on insert enter",
		})

		local copilot_suggestion = require("copilot.suggestion")

		vim.keymap.set("i", "<C-j>", function()
			if copilot_suggestion.is_visible() then
				copilot_suggestion.next()
			else
				vim.b.copilot_suggestion_hidden = false
				copilot_suggestion.dismiss()
				copilot_suggestion.next()
			end
		end, { silent = true })

		vim.keymap.set("i", "<C-l>", function()
			if copilot_suggestion.is_visible() then
				copilot_suggestion.accept()
			end
		end, { silent = true })
	end,
}

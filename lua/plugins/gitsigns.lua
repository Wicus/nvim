return {
	"lewis6991/gitsigns.nvim",
	opts = {
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			vim.keymap.set("n", "]g", function()
				if vim.wo.diff then
					return "]g"
				end
				vim.schedule(function() gs.next_hunk() end)
				return "<Ignore>"
			end, { expr = true })

			vim.keymap.set("n", "[g", function()
				if vim.wo.diff then
					return "[g"
				end
				vim.schedule(function() gs.prev_hunk() end)
				return "<Ignore>"
			end, { expr = true })

			vim.keymap.set("n", "<leader>gp", gs.preview_hunk)
			vim.keymap.set("n", "<leader>gr", gs.reset_hunk)
			vim.keymap.set("n", "<leader>gh", gs.stage_hunk)
			vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk)
			vim.keymap.set("n", "<leader>gR", gs.reset_buffer)
			vim.keymap.set("n", "<leader>gb", gs.blame_line)
		end,
	},
}

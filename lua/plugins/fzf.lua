return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
    lazy = false,
	keys = {
		{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Find recent files" },
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
		{ "<leader>sl", "<cmd>FzfLua resume<cr>", desc = "Resume" },
		{ "<leader>sj", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "LSP document symbols" },
		{ "<leader>sb", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Search in buffer" },
		{ "<leader>bb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
		{ "<leader>gg", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
		{ "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
		{ "<leader>*", "<cmd>FzfLua grep_cword<cr>", desc = "Grep cword" },
		{ "<leader>*", "<cmd>FzfLua grep_visual<cr>", desc = "Grep visual selection", mode = "x" },
	},
	config = function()
		require("fzf-lua").setup({
			"telescope",
			defaults = {
				file_icons = "mini",
			},
			files = { formatter = "path.filename_first" },
			git = { status = { formatter = "path.filename_first" } },
			grep = { formatter = "path.filename_first" },
			oldfiles = {
				formatter = "path.filename_first",
				cwd_only = true,
			},
			buffers = { formatter = "path.filename_first" },
			lsp = { formatter = "path.filename_first" },
		})

		require("fzf-lua").register_ui_select(function(fzf_opts, items)
			local codeaction_opts = {
				winopts = {
					layout = "vertical",

					-- height is number of items minus 15 lines for the preview, with a max of 80% screen height
					height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
					width = 0.5,
					preview = {
						layout = "vertical",
						vertical = "down:15,border-top",
					},
				},
			}

			local default_opts = {
				winopts = {
					layout = "vertical",
					width = 0.5,
					-- height is number of items, with a max of 80% screen height
					height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
				},
			}

			if fzf_opts.kind == "codeaction" then
				return codeaction_opts
			end

			return default_opts
		end)
	end,
}

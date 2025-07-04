return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		custom_highlights = function(colors)
			return {
				-- TreesitterContext = { bg = colors.mantle },
				-- TreesitterContextLineNumber = { bg = colors.mantle, fg = colors.red },
				-- TreesitterContextBottom = { style = {} },
				-- NormalFloat = { bg = colors.none },
				VertSplit = { fg = colors.mantle, bg = colors.mantle },
				-- MiniTrailspace = { bg = colors.red },
				-- FlashCurrent = { bg = colors.peach, fg = colors.base },
				-- FlashLabel = { bg = colors.red, bold = true, fg = colors.base },
				-- FlashMatch = { bg = colors.blue, fg = colors.base },
				-- FlashCursor = { reverse = true },
				NeoTreeWinSeparator = { fg = colors.mantle, bg = colors.mantle },
				-- CursorLineNr = { fg = colors.peach },
				-- TelescopePromptBorder = { fg = colors.rosewater },
				-- TelescopeTitle = { fg = colors.rosewater },
				SnacksIndent = { fg = "#313244" },
				SnacksIndentScope = { fg = "#6c7086" },
				MiniCursorword = { bg = "#45475a", style = {} },
				MiniCursorwordCurrent = { bg = "#45475a", style = {} },
				DiagnosticError = { style = {} },
                DiagnosticWarn = { style = {} },
                DiagnosticInfo = { style = {} },
                DiagnosticHint = { style = {} },
                DiagnosticOk = { style = {} }
			}
		end,
		integrations = {
			aerial = true,
			alpha = true,
			dap = true,
			dap_ui = true,
			cmp = true,
			dashboard = true,
			flash = true,
			fzf = true,
			grug_far = true,
			gitsigns = true,
			headlines = true,
			illuminate = true,
			indent_blankline = { enabled = true },
			leap = true,
			lsp_trouble = true,
			mason = true,
			markdown = true,
			mini = true,
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
			navic = { enabled = true, custom_bg = "lualine" },
			neotest = true,
			neotree = true,
			noice = true,
			notify = true,
			semantic_tokens = true,
			snacks = true,
			telescope = true,
			treesitter = true,
			treesitter_context = true,
			which_key = true,
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}

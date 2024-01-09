return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		flavour = "mocha", -- latte, frappe, macchiato, mocha
		background = { -- :h background
			light = "latte",
			dark = "mocha",
		},
		transparent_background = false,
		show_end_of_buffer = false, -- show the '~' characters after the end of buffers
		term_colors = false,
		dim_inactive = {
			enabled = false,
			shade = "dark",
			percentage = 0.15,
		},
		no_italic = false, -- Force no italic
		no_bold = false, -- Force no bold
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
		},
		color_overrides = {},
		custom_highlights = function(colors)
			return {
				WhichKey = { bg = colors.mantle },
				WhichKeyFloat = { bg = colors.mantle },
				TreesitterContext = { bg = colors.mantle },
				TreesitterContextLineNumber = { bg = colors.mantle, fg = colors.red },
				TreesitterContextBottom = { style = {} },
				NormalFloat = { bg = colors.none },
				VertSplit = { fg = colors.mantle, bg = colors.mantle },
				MiniTrailspace = { bg = colors.red },
				FlashCurrent = { bg = colors.peach, fg = colors.base },
				FlashLabel = { bg = colors.red, bold = true, fg = colors.base },
				FlashMatch = { bg = colors.blue, fg = colors.base },
				FlashCursor = { reverse = true },
			}
		end,
		integrations = {
			cmp = true,
			gitsigns = true,
			telescope = true,
			illuminate = true,
			mason = true,
			markdown = true,
			harpoon = true,
			which_key = true,
			treesitter_context = true,
			flash = true,
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)

		vim.cmd.colorscheme("catppuccin")
	end,
}

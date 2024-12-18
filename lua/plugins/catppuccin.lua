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
		transparent_background = false, -- disables setting the background color.
		show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
		term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
		dim_inactive = {
			enabled = false, -- dims the background color of inactive window
			shade = "dark",
			percentage = 0.15, -- percentage of the shade to apply to the inactive window
		},
		no_italic = false, -- Force no italic
		no_bold = false, -- Force no bold
		no_underline = false, -- Force no underline
		styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
			comments = { "italic" }, -- Change the style of comments
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
			-- miscs = {}, -- Uncomment to turn off hard-coded styles
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
				NeoTreeWinSeparator = { fg = colors.mantle, bg = colors.mantle },
				-- CursorLineNr = { fg = colors.peach },
				-- TelescopePromptBorder = { fg = colors.rosewater },
				-- TelescopeTitle = { fg = colors.rosewater },
			}
		end,
		default_integrations = true,
		integrations = {
			aerial = true,
			alpha = true,
			cmp = true,
			dashboard = true,
			flash = true,
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
			telescope = {
				enabled = true,
				-- style = "nvchad",
			},
			treesitter = true,
			treesitter_context = true,
			which_key = true,
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)

		vim.cmd.colorscheme("catppuccin")
	end,
	cond = true,
}

-- Mocha colors
--
-- rosewater = "#f5e0dc",
-- flamingo = "#f2cdcd",
-- pink = "#f5c2e7",
-- mauve = "#cba6f7",
-- red = "#f38ba8",
-- maroon = "#eba0ac",
-- peach = "#fab387",
-- yellow = "#f9e2af",
-- green = "#a6e3a1",
-- teal = "#94e2d5",
-- sky = "#89dceb",
-- sapphire = "#74c7ec",
-- blue = "#89b4fa",
-- lavender = "#b4befe",
-- text = "#cdd6f4",
-- subtext1 = "#bac2de",
-- subtext0 = "#a6adc8",
-- overlay2 = "#9399b2",
-- overlay1 = "#7f849c",
-- overlay0 = "#6c7086",
-- surface2 = "#585b70",
-- surface1 = "#45475a",
-- surface0 = "#313244",
-- base = "#1e1e2e",
-- mantle = "#181825",
-- crust = "#11111b",

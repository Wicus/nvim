return {
	"nvim-lualine/lualine.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"catppuccin/nvim",
	},
	config = function()
		local catppuccin_colors = require("catppuccin.palettes").get_palette("mocha")

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = function()
					local catppuccin_theme = require("lualine.themes.catppuccin")
					catppuccin_theme.normal.b.bg = catppuccin_colors.mantle
					catppuccin_theme.insert.b.bg = catppuccin_colors.mantle
					catppuccin_theme.visual.b.bg = catppuccin_colors.mantle
					catppuccin_theme.command.b.bg = catppuccin_colors.mantle
					catppuccin_theme.replace.b.bg = catppuccin_colors.mantle

					return catppuccin_theme
				end,
				component_separators = "|",
				section_separators = "",
				disabled_filetypes = {},
			},
			sections = {
				lualine_c = {},
			},
			winbar = {
				lualine_b = { { "filename", path = 1, color = { fg = catppuccin_colors.lavender } } },
			},
			inactive_winbar = {
				lualine_b = { { "filename", path = 1 } },
			},
		})
	end,
}

return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			providers = {
				"regex",
				"treesitter",
				"lsp",
			},
			filetypes_denylist = {
				"dirvish",
				"fugitive",
				"neo-tree",
			},
		})
	end,
}

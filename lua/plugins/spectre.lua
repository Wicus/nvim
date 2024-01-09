return {
	"nvim-pack/nvim-spectre",
	keys = {
		{ "<leader>sr", function() require("spectre").open() end, { desc = "Search and replace (Spectre)" } },
	},
	config = function()
		local spectre_sed_args = require("spectre.config").replace_engine.sed.args
		spectre_sed_args[#spectre_sed_args + 1] = "-b"
	end,
}

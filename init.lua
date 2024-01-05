require("config.lazy")
require("config.options")
require("config.autocmds")
require("config.usercomands")

if not vim.g.vscode then
	require("config.keymaps")
else
	require("config.vscode-keymaps")
end

local M = {}

M.lsp_config_on_attach = function(client, bufnr)
	local telescope_builtin = require("telescope.builtin")
	vim.keymap.set("n", "cn", vim.lsp.buf.rename, { desc = "[C]hange [N]ame (Rename)" })
	vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })
	vim.keymap.set("n", "gr", telescope_builtin.lsp_references, { desc = "[G]oto [R]eferences" })
	vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, { desc = "Goto to type implementations" })
	vim.keymap.set("n", "gt", telescope_builtin.lsp_type_definitions, { desc = "[G]oto [T]ype definition" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
	vim.keymap.set("n", "<M-w>", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" }) -- <M-w> is remapped to <C-.> in AutoHotKey
	vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" }) -- This is for other terminal emulators
end

return M

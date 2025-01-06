vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*", group = vim.api.nvim_create_augroup("TextYankPostGroup", { clear = true }),
	callback = function() vim.highlight.on_yank({ timeout = 40 }) end,
})

vim.api.nvim_create_user_command("Wa", "wa", { desc = "wall" })

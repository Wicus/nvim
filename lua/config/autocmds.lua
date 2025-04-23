vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = vim.api.nvim_create_augroup("TextYankPostGroup", { clear = true }),
	callback = function() vim.highlight.on_yank({ timeout = 40 }) end,
})

vim.api.nvim_create_user_command("Wa", "wa", { desc = "wall" })

-- vim.api.nvim_create_autocmd("QuitPre", {
-- 	group = vim.api.nvim_create_augroup("QuitPreGroup", { clear = true }),
-- 	callback = function()
-- 		local snacks_windows = {}
-- 		local floating_windows = {}
-- 		local windows = vim.api.nvim_list_wins()
-- 		for _, w in ipairs(windows) do
-- 			local filetype = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(w) })
-- 			if filetype:match("snacks_") ~= nil then
-- 				table.insert(snacks_windows, w)
-- 			elseif vim.api.nvim_win_get_config(w).relative ~= "" then
-- 				table.insert(floating_windows, w)
-- 			end
-- 		end
-- 		if 1 == #windows - #floating_windows - #snacks_windows then
-- 			-- Should quit, so we close all Snacks windows.
-- 			for _, w in ipairs(snacks_windows) do
-- 				vim.api.nvim_win_close(w, true)
-- 			end
-- 		end
-- 	end,
-- })


vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("NEOTREE_AUGROUP", { clear = true }),
    callback = function()
        vim.defer_fn(function()
            vim.cmd("Neotree")
        end, 10)
    end,
})

local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local utils = require("telescope.utils")

M.search_git_status = function(opts)
	opts = opts or {}

	local results = {}
	local output = utils.get_os_command_output({ "git", "diff-index", "-U0", "HEAD" }, opts.cwd)
	local path = ""
	local line_num = 0

	for _, v in ipairs(output) do
		local fields = vim.split(v, "%s+")
		if fields[1] == "+++" then
			path = string.sub(fields[2], 3, -1)
			local cwd = vim.fn.getcwd()
			local cwd_parts = vim.split(cwd, "\\")
			local path_parts = vim.split(path, "/")

			while true do
				local found = false
				for i = #cwd_parts, 1, -1 do
					if cwd_parts[i] == path_parts[1] then
						table.remove(path_parts, 1)
						found = true
						break
					end
				end
				if not found then
					-- TODO: Handle case when git root should be done
					break
				end
			end

			path = table.concat(path_parts, "\\")
		end
		if fields[1] == "@@" then
			local match = string.match(fields[3], "%d+")
			line_num = match and tonumber(match) or 0
		end
		if fields[1] == "+" then
			local diff = v:gsub("%+", "")
			table.insert(results, { path, path, line_num, diff })
		end
	end

	pickers
		.new(opts, {
			prompt_title = "Search Git Status",
			finder = finders.new_table({
				results = results,
				entry_maker = function(entry)
					local display = entry[1] .. " L:" .. entry[3] .. ":" .. entry[4]
					local ordinal = entry[1] .. entry[4]
					return {
						value = entry,
						display = display,
						ordinal = ordinal,
						path = entry[2],
						lnum = entry[3],
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			previewer = conf.grep_previewer(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					vim.api.nvim_command("edit +" .. selection.lnum .. " " .. selection.path)
				end)
				return true
			end,
		})
		:find()
end

return M

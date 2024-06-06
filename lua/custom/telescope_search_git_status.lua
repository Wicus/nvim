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
	local filename = ""
	local line_num = 0
	for _, v in ipairs(output) do
		local fields = vim.split(v, "%s+")
		if fields[1] == "+++" then
			filename = string.sub(fields[2], 3, -1)
			path = vim.fn.getcwd() .. "\\" .. filename
		end
		if fields[1] == "@@" then
			local match = string.match(fields[3], "%d+")
			line_num = match and tonumber(match) or 0
		end
		if fields[1] == "+" then
			local diff = v:gsub("%+", "")
			table.insert(results, { filename, path, line_num, diff })
		end
	end
	pickers
		.new(opts, {
			prompt_title = "Search Git Status",
			finder = finders.new_table({
				results = results,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry[1] .. " " .. entry[3] .. " " .. entry[4],
						ordinal = entry[1],
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

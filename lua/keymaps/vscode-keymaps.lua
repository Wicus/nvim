if not vim.g.vscode then
	return
end

local vscode = require("vscode-neovim")
local keymaps = require("keymaps.core").keymaps
local vim_keymap_set = require("keymaps.core").vim_keymap_set

-- Global
vim_keymap_set(keymaps.paste, function() vscode.action("editor.action.clipboardPasteAction") end)
vim_keymap_set(keymaps.explorer, function() vscode.action("workbench.files.action.focusFilesExplorer") end)
vim_keymap_set(keymaps.qflist_toggle, function() vscode.action("workbench.action.togglePanel") end)

-- Diagnostics
vim_keymap_set(keymaps.diagnostics_help, function() vscode.action("editor.action.showHover") end)
vim_keymap_set(keymaps.diagnostics_next, function() vscode.action("editor.action.marker.next") end)
vim_keymap_set(keymaps.diagnostics_prev, function() vscode.action("editor.action.marker.prev") end)
vim_keymap_set(keymaps.error_next, function() vscode.action("editor.action.marker.next") end)
vim_keymap_set(keymaps.error_prev, function() vscode.action("editor.action.marker.prev") end)

-- Formatting
vim_keymap_set(keymaps.format_selection_n, function() vscode.action("editor.action.formatSelection") end)
vim_keymap_set(keymaps.format_selection_v, function() vscode.action("editor.action.formatSelection") end)

-- Find in files
vim_keymap_set(keymaps.live_grep_n, function() vscode.action("workbench.action.findInFiles") end)
vim_keymap_set(keymaps.live_grep_v, function() vscode.action("workbench.action.findInFiles") end)
vim_keymap_set(keymaps.live_grep_selection, function() vscode.action("workbench.action.findInFiles") end)

-- Copilot keymaps
vim_keymap_set(keymaps.chat, function() vscode.action("workbench.action.chat.openInEditor") end)
vim_keymap_set(keymaps.chat_vsplit, function() vscode.action("workbench.panel.chat.view.copilot.focus") end)
vim_keymap_set(keymaps.chat_quick, function() vscode.action("workbench.action.quickchat.toggle") end)
vim_keymap_set(keymaps.chat_inline, function() vscode.action("inlineChat.start") end)

-- Buffers
vim_keymap_set(keymaps.buffers, function() vscode.action("workbench.action.showAllEditors") end)

-- LSP keymaps
vim_keymap_set(keymaps.rename, function() vscode.action("editor.action.rename") end)
vim_keymap_set(keymaps.lsp_go_to_definition, function() vscode.action("editor.action.referenceSearch.trigger") end)
vim_keymap_set(keymaps.lsp_go_to_references, function() vscode.action("editor.action.revealDefinition") end)
vim_keymap_set(keymaps.lsp_go_to_implementation, function() vscode.action("editor.action.goToImplementation") end)
vim_keymap_set(keymaps.lsp_go_to_type_definition, function() vscode.action("editor.action.goToTypeDefinition") end)
vim_keymap_set(keymaps.lsp_hover, function() vscode.action("editor.action.showHover") end)
vim_keymap_set(keymaps.lsp_signature_help_n, function() vscode.action("editor.action.showHover") end)

-- Git keymaps
vim_keymap_set(keymaps.git_status, function() vscode.action("workbench.view.scm") end)
vim_keymap_set(keymaps.git_next_hunk, function() vscode.action("workbench.action.editor.nextChange") end)
vim_keymap_set(keymaps.git_prev_hunk, function() vscode.action("workbench.action.editor.previousChange") end)
vim_keymap_set(keymaps.git_reset_hunk, function() vscode.action("git.revertSelectedRanges") end)
vim_keymap_set(keymaps.git_reset_buffer, function() vscode.action("git.clean") end)
vim_keymap_set(keymaps.git_diffthis, function() vscode.action("git.openChange") end)
vim_keymap_set(keymaps.git_preview_hunk, function() vscode.action("git.openChange") end)

-- Commenting
vim_keymap_set(keymaps.comment_line_n, function() vscode.action("editor.action.commentLine") end)
vim_keymap_set(keymaps.comment_line_v, function() vscode.action("editor.action.commentLine") end)

-- Source this file
vim_keymap_set(keymaps.source_config, function() vim.cmd("source ~/AppData/Local/nvim/init.lua") end)

print("vscode-neovim vscode-keymaps.lua successfully loaded")

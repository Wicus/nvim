return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter" },
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		-- Adds LSP completion capabilities
		"hrsh7th/cmp-nvim-lsp",

		-- Adds other sources for nvim-cmp
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"f3fora/cmp-spell", -- This is really annoying as it pops up the whole time while I'm writing

		-- Adds a number of user-friendly snippets
		"rafamadriz/friendly-snippets",
		"zbirenbaum/copilot.lua",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local cmp_kinds = {
			Text = "  ",
			Method = "  ",
			Function = "  ",
			Constructor = "  ",
			Field = "  ",
			Variable = "  ",
			Class = "  ",
			Interface = "  ",
			Module = "  ",
			Property = "  ",
			Unit = "  ",
			Value = "  ",
			Enum = "  ",
			Keyword = "  ",
			Snippet = "  ",
			Color = "  ",
			File = "  ",
			Reference = "  ",
			Folder = "  ",
			EnumMember = "  ",
			Constant = "  ",
			Struct = "  ",
			Event = "  ",
			Operator = "  ",
			TypeParameter = "  ",
			Copilot = "  ",
		}

		-- Disable copilot suggestions when the completion menu is open
		-- ---@diagnostic disable-next-line: inject-field
		-- cmp.event:on("menu_opened", function() vim.b.copilot_suggestion_hidden = true end)
		-- ---@diagnostic disable-next-line: inject-field
		-- cmp.event:on("menu_closed", function() vim.b.copilot_suggestion_hidden = false end)

		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.config.setup({})
		local copilot = require("copilot")
		local copilot_suggestion = require("copilot.suggestion")

		cmp.setup({
			---@diagnostic disable-next-line: missing-fields
			view = { entries = { follow_cursor = false } },
			snippet = {
				expand = function(args) luasnip.lsp_expand(args.body) end,
			},
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			window = {
				completion = cmp.config.window.bordered({
					border = "single",
				}),
				documentation = cmp.config.window.bordered({
					border = "single",
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<M-/>"] = cmp.mapping(function() luasnip.expand() end, { "i", "s" }),
				["<C-o>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				-- This doesn't work sometimes, i need a way to disable to builtin <C-i>
				["<C-i>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping.complete(),
				["<C-k>"] = cmp.mapping(function(fallback)
					if copilot_suggestion.is_visible() then
						copilot_suggestion.dismiss()
					elseif cmp.visible() then
						cmp.close()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-l>"] = cmp.mapping(function(fallback)
					if copilot_suggestion.is_visible() then
						copilot_suggestion.accept()
					elseif cmp.visible() then
						cmp.confirm({ select = true })
					else
						fallback()
					end
				end, { "i", "s" }),

				-- Mapping that I'm used to... to be removed later
				-- ["<C-Space>"] = cmp.mapping.complete({}), -- This is for other terminal emulators
				["<M-q>"] = cmp.mapping.complete({}), -- <M-q> is remapped to <C-Space> in AutoHotKey
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "path" },
				{ name = "buffer", keyword_length = 5 },
			}, {
				{ name = "spell", keyword_length = 5 },
			}),
		})
	end,
	cond = function() return not vim.g.vscode end,
}

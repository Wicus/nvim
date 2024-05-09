return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter" },
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		-- Adds LSP completion capabilities
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"f3fora/cmp-spell",

		-- Adds a number of user-friendly snippets
		"rafamadriz/friendly-snippets",
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
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-u>"] = cmp.mapping.scroll_docs(4),

				-- <M-q> is remapped to <C-Space> in AutoHotKey
				["<M-q>"] = cmp.mapping.complete({}),

				-- This is for other terminal emulators
				-- ["<C-Space>"] = cmp.mapping.complete({}),

				["<C-y>"] = cmp.mapping.confirm({
					select = true,
				}),
				["<CR>"] = cmp.mapping.confirm({
					select = true,
				}),
				["<M-/>"] = cmp.mapping(function() luasnip.expand() end, { "i", "s" }),
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp", group_index = 1 },
				{ name = "luasnip", group_index = 1 },
				{ name = "copilot", group_index = 2 },
				{ name = "path", group_index = 2 },
				{ name = "spell", keyword_length = 5, group_index = 2 },
			},
		})
	end,
	cond = function() return not vim.g.vscode end,
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local is_windows = string.lower(vim.loop.os_uname().sysname) == "windows_nt"

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
	-- TODO: Reorganize and cleanup
	-- TODO: Check for plugins that take long and lazy load only those
	-- TODO: Check these keys and opts that we are passing, maybe just make it simpler.
	-- TODO: Split plugins into their own files
	--
	-- Utilities used by plugins
	"nvim-lua/plenary.nvim",
	-- Icons
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"tpope/vim-surround", -- Surround text objects with quotes, brackets, etc

	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_filetypes = { TelescopePrompt = false, text = false, markdown = true }
			vim.g.copilot_assume_mapped = true
		end,
	},

	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				providers = {
					"regex",
					"treesitter",
					"lsp",
				},
				filetypes_denylist = {
					"dirvish",
					"fugitive",
					"neo-tree",
				},
			})
		end,
	},

	{
		"stevearc/dressing.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("dressing").setup({
				input = {
					insert_only = true,
					start_in_insert = false,
					title_pos = "center",
					win_options = {
						winblend = 0,
					},
					border = "single",
				},
				select = {
					telescope = require("telescope.themes").get_dropdown({
						borderchars = {
							prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
							results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
							preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
						},
					}),
				},
			})
		end,
	},

	{
		"mhartington/formatter.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- Formatter setup
			require("formatter").setup({
				filetype = {
					lua = { require("formatter.filetypes.lua").stylua },
					javascript = { require("formatter.filetypes.javascript").prettierd },
					javascriptreact = { require("formatter.filetypes.javascriptreact").prettierd },
					typescript = { require("formatter.filetypes.typescript").prettierd },
					typescriptreact = { require("formatter.filetypes.typescriptreact").prettierd },
					h = { require("formatter.defaults").clangformat },
					c = { require("formatter.defaults").clangformat },
					cpp = { require("formatter.defaults").clangformat },
					hpp = { require("formatter.defaults").clangformat },
					cs = vim.lsp.buf.format,
					python = vim.lsp.buf.format,
					json = { require("formatter.filetypes.json").prettierd },
					xml = vim.lsp.buf.format,
				},
			})

			-- Format on save autocommand
			local formatting_group = vim.api.nvim_create_augroup("fomat", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePost", {
				command = "FormatWriteLock",
				group = formatting_group,
				pattern = {
					"*.tsx",
					"*.ts",
					"*.jsx",
					"*.js",
					"*.lua",
					-- "*.cs",
					-- "*.cpp",
					-- "*.hpp",
					-- "*.json",
				},
			})

			vim.keymap.set("n", "<leader>ff", "<cmd>FormatWriteLock<cr>", { desc = "[F]ormat [F]ile" })
		end,
	},

	{ "norcalli/nvim-colorizer.lua", config = true },

	{ "echasnovski/mini.trailspace", config = true },

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			-- Additional text objects via treesitter
			"nvim-treesitter/nvim-treesitter-textobjects",
			{
				"nvim-treesitter/nvim-treesitter-context",
				opts = {
					enable = true,
					max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
				},
			},
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"c_sharp",
					"cpp",
					"css",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
				},
				highlight = {
					enable = true,
				},
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<leader>v",
						node_incremental = "v",
						node_decremental = "V",
						scope_incremental = "<C-s>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- if it's linux the the string should just be "make"
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<Up>"] = actions.cycle_history_prev,
							["<Down>"] = actions.cycle_history_next,
						},
					},
					borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					path_display = function(opts, path)
						local tail = require("telescope.utils").path_tail(path)
						local relative_path = vim.fn.fnamemodify(path, ":.:h")
						return string.format("%s (%s)", tail, relative_path)
					end,
				},
				pickers = {
					live_grep = {
						mappings = {
							i = { ["<c-f>"] = actions.to_fuzzy_refine },
						},
					},
				},
			})
			telescope.load_extension("fzf")

			local builtin = require("telescope.builtin")
			local glob_pattern = {
				"!src/shared/dygraphs/**",
				"!src/shared/canvas-gauges/**",
			}

			vim.keymap.set("n", "<leader>fr", function() builtin.oldfiles({ cwd_only = true }) end, { desc = "[F]ile [R]ecent: Find recently opened files" })
			vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "[B]uffers [B]uffers: Find existing buffers" })
			vim.keymap.set("n", "<leader>gg", builtin.git_status, { desc = "[G][G]it files" })
			vim.keymap.set("n", "<leader>sl", builtin.resume, { desc = "[S]ession [L]ast (resume telescope)" })
			vim.keymap.set("n", "<leader>sj", builtin.lsp_document_symbols, { desc = "[S]earch [J]ump: Jump to symbol" })
			vim.keymap.set(
				"n",
				"<leader>/",
				function() builtin.live_grep({ glob_pattern = glob_pattern, additional_args = { "--fixed-strings" } }) end,
				{ desc = "[/]: Search in project" }
			)
			vim.keymap.set(
				"n",
				"<leader>*",
				function() builtin.grep_string({ glob_pattern = glob_pattern, word_match = "-w" }) end,
				{ desc = "[*]: Search current word in project (Case Sensitive)" }
			)
			local function get_visual_selected()
				vim.cmd('normal "vy')
				return vim.fn.getreg("v") or ""
			end
			vim.keymap.set(
				"v",
				"<leader>*",
				function()
					builtin.live_grep({
						default_text = get_visual_selected(),
						glob_pattern = glob_pattern,
						additional_args = { "--case-sensitive", "--fixed-strings", "--word-regexp" },
					})
				end,
				{ desc = "[*]: Search current word in project (Case Sensitive) (Word Boundary)" }
			)
		end,
	},

	{
		"mbbill/undotree",
		keys = {
			{
				"<leader>u",
				vim.cmd.UndotreeToggle,
				{ desc = "Undo tree toggle" },
			},
		},
		config = function() vim.g.undotree_SetFocusWhenToggle = 1 end,
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				vim.keymap.set("n", "]g", function()
					if vim.wo.diff then
						return "]g"
					end
					vim.schedule(function() gs.next_hunk() end)
					return "<Ignore>"
				end, { expr = true })

				vim.keymap.set("n", "[g", function()
					if vim.wo.diff then
						return "[g"
					end
					vim.schedule(function() gs.prev_hunk() end)
					return "<Ignore>"
				end, { expr = true })

				vim.keymap.set("n", "<leader>gp", gs.preview_hunk)
				vim.keymap.set("n", "<leader>gr", gs.reset_hunk)
				vim.keymap.set("n", "<leader>gR", gs.reset_buffer)
				vim.keymap.set("n", "<leader>gs", gs.diffthis)
			end,
		},
	},

	{
		"nvim-pack/nvim-spectre",
		keys = {
			{ "<leader>sr", function() require("spectre").open() end, { desc = "Search and replace (Spectre)" } },
		},
		config = function()
			local spectre_sed_args = require("spectre.config").replace_engine.sed.args
			spectre_sed_args[#spectre_sed_args + 1] = "-b"
		end,
	},

	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<leader>bd",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				{ desc = "Buffer delete" },
			},
		},
	},

	{
		"ThePrimeagen/harpoon",
		opts = {
			menu = {
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				-- width = vim.api.nvim_win_get_width(0) - 140,
			},
		},
		keys = {
			{ "<leader>fa", function() require("harpoon.mark").add_file() end, { desc = "Harpoon add file" } },
			{ "<leader>0", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Harpoon quick menu" } },
			{ "<leader>1", function() require("harpoon.ui").nav_file(1) end, { desc = "Harpoon file 1" } },
			{ "<leader>2", function() require("harpoon.ui").nav_file(2) end, { desc = "Harpoon file 2" } },
			{ "<leader>3", function() require("harpoon.ui").nav_file(3) end, { desc = "Harpoon file 3" } },
			{ "<leader>4", function() require("harpoon.ui").nav_file(4) end, { desc = "Harpoon file 4" } },
			{ "<leader>5", function() require("harpoon.ui").nav_file(5) end, { desc = "Harpoon file 5" } },
		},
	},

	{
		"folke/flash.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local flash = require("flash")

			vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash jump" })
			vim.keymap.set("n", "<leader>ts", flash.toggle, { desc = "Toggle flash" })
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
			show_end_of_buffer = false, -- show the '~' characters after the end of buffers
			term_colors = false,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {},
			custom_highlights = function(colors)
				return {
					WhichKey = { bg = colors.mantle },
					WhichKeyFloat = { bg = colors.mantle },
					TreesitterContext = { bg = colors.mantle },
					TreesitterContextLineNumber = { bg = colors.mantle, fg = colors.red },
					TreesitterContextBottom = { style = {} },
					NormalFloat = { bg = colors.none },
					VertSplit = { fg = colors.mantle, bg = colors.mantle },
					MiniTrailspace = { bg = colors.red },
					FlashCurrent = { bg = colors.peach, fg = colors.base },
					FlashLabel = { bg = colors.red, bold = true, fg = colors.base },
					FlashMatch = { bg = colors.blue, fg = colors.base },
					FlashCursor = { reverse = true },
				}
			end,
			integrations = {
				cmp = true,
				gitsigns = true,
				telescope = true,
				illuminate = true,
				mason = true,
				markdown = true,
				harpoon = true,
				which_key = true,
				treesitter_context = true,
				flash = true,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)

			vim.cmd.colorscheme("catppuccin")
		end,
	},

	{
		"shortcuts/no-neck-pain.nvim",
		version = "1.6.3",
		opts = {
			width = 180,
			autocmds = {
				enableOnVimEnter = true,
			},
			buffers = {
				right = {
					enabled = false,
				},
				colors = {
					blend = -0.2,
				},
				scratchPad = {
					enabled = false,
				},
			},
		},
	},

	{
		"stevearc/oil.nvim",
		keys = { { "-", function() require("oil.actions").parent.callback() end, desc = "Open oil in current working directory" } },
		opts = {
			keymaps = {
				["q"] = "actions.close",
				["g-"] = function()
					if is_windows then
						require("oil.actions").tcd.callback()
						vim.cmd("silent !explorer .")
					end
				end,
				["<C-p>"] = false,
			},
			columns = {},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "│" },
			scope = { enabled = false },
		},
	},

	{ "numToStr/Comment.nvim", event = { "BufReadPre", "BufNewFile" }, config = true },

	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"catppuccin/nvim",
		},
		config = function()
			local catppuccin_colors = require("catppuccin.palettes").get_palette("mocha")

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = function()
						local catppuccin_theme = require("lualine.themes.catppuccin")
						catppuccin_theme.normal.b.bg = catppuccin_colors.mantle
						catppuccin_theme.insert.b.bg = catppuccin_colors.mantle
						catppuccin_theme.visual.b.bg = catppuccin_colors.mantle
						catppuccin_theme.command.b.bg = catppuccin_colors.mantle
						catppuccin_theme.replace.b.bg = catppuccin_colors.mantle

						return catppuccin_theme
					end,
					component_separators = "|",
					section_separators = "",
					disabled_filetypes = {},
				},
				sections = {
					lualine_c = {},
				},
				winbar = {
					lualine_b = { { "filename", path = 1, color = { fg = catppuccin_colors.lavender } } },
				},
				inactive_winbar = {
					lualine_b = { { "filename", path = 1 } },
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"Hoffs/omnisharp-extended-lsp.nvim",
			{ "folke/neodev.nvim", config = true },
			{ "j-hui/fidget.nvim", config = true },
		},
		config = function()
			-- Set border for floating windows
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers["textDocument/hover"], { border = "single" })
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["textDocument/signatureHelp"], { border = "single" })
			vim.diagnostic.config({ float = { border = "single" } })

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"tsserver",
					"eslint",
					"clangd",
					"pyright",
					"omnisharp@v1.39.8",
					"jsonls",
					"intelephense",
					"html",
					"cssls",
					"tailwindcss",
					"lemminx",
				},
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"prettierd",
					"clang-format",
				},
			})

			local lspconfig = require("lspconfig")
			local config = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
				on_attach = function(client, bufnr)
					-- Has a AutoHotKey script to change this to <C-.> for windows
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
					vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
					vim.keymap.set("n", "cn", vim.lsp.buf.rename, { desc = "[C]hange [N]ame (Rename)" })
					vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "[G]oto [D]efinition" })
					vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
					vim.keymap.set("n", "gy", require("telescope.builtin").lsp_implementations, { desc = "Goto to type implementations" })
					vim.keymap.set("n", "gt", require("telescope.builtin").lsp_type_definitions, { desc = "[G]oto [T]ype definition" })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
					vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

					-- Omnisharp overrides
					if client.name == "omnisharp" then
						vim.keymap.set("n", "gd", require("omnisharp_extended").telescope_lsp_definitions, { desc = "[G]oto [D]efinition" })
					end
				end,
			}
			local config_with_opts = function(settings) return vim.tbl_deep_extend("force", config, settings) end
			lspconfig.tsserver.setup(config)
			lspconfig.eslint.setup(config)
			lspconfig.clangd.setup(config)
			lspconfig.pyright.setup(config)
			lspconfig.jsonls.setup(config)
			lspconfig.intelephense.setup(config)
			lspconfig.html.setup(config)
			lspconfig.cssls.setup(config)
			lspconfig.lemminx.setup(config)
			lspconfig.lua_ls.setup(config_with_opts({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			}))
			lspconfig.omnisharp.setup(config_with_opts({
				cmd = { "cmd", "/c", "omnisharp" },
				handlers = { ["textDocument/definition"] = require("omnisharp_extended").handler },
			}))
		end,
	},

	{
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
			}

			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup({})

			cmp.setup({
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
				formatting = {
					format = function(_, vim_item)
						vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-u>"] = cmp.mapping.scroll_docs(4),

					["<C-l>"] = cmp.mapping.complete({}), -- Has a AutoHotKey script to change this to <C-Space>
					["<C-Space>"] = cmp.mapping.complete({}), -- This is for other terminal emulators

					["<C-y>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),

					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.locally_jumpable() then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "spell" },
				},
			})
		end,
	},

	{
		"folke/which-key.nvim",
		config = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 300

			require("which-key").setup({
				plugins = {
					registers = false,
				},
			})
		end,
	},
})

-- [[ Options ]]
vim.opt.laststatus = 3 -- Always show statusline

-- Sane defaults for tabs and spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set highlight on search to false
vim.opt.hlsearch = true

-- Make line numbers default
vim.wo.number = true
-- vim.opt.relativenumber = true

-- Enable break indent
vim.opt.breakindent = true

-- Enable / Disable backup files
vim.opt.swapfile = false
vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand("~/nvim-backup-folder")

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 50

-- Set colorscheme
vim.opt.background = "dark"
vim.opt.termguicolors = true

-- Set completeopt to have a better completion experience
-- vim.opt.completeopt = "menuone,noselect"

-- Highlight current linenumber
-- vim.opt.cursorline = true

-- Color column
vim.opt.colorcolumn = "120"

-- Spelling
vim.opt.spell = false
vim.opt.spelllang = "en_us"

-- Clipboard
-- vim.opt.clipboard = "unnamedplus"

-- TODO: Could remove this?
-- WSL clipboard
if vim.fn.has("wsl") then
	-- Command to fix interpreter not found (https://github.com/microsoft/WSL/issues/5466):
	-- `sudo update-binfmts --disable cli`
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end

-- Always show the signcolumn, otherwise it would shift the text each time
vim.wo.signcolumn = "yes"

-- We don't need to see things like -- INSERT -- anymore
vim.opt.showmode = false

-- Better splits when opening buffers
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set guifont
vim.opt.guifont = "Consolas:h9"

-- Line wrap
vim.opt.wrap = false

-- File Format
vim.opt.fileformat = "unix"

local function get_visual_selected()
	vim.cmd('normal "vy')
	return vim.fn.getreg("v") or ""
end
local function get_work_under_cursor()
	vim.cmd('normal viw"vy')
	return vim.fn.getreg("v") or ""
end

-- [[ Keymaps ]]
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Pasting will not replace the current register with what is selected
vim.keymap.set("x", "p", '"_dP')

-- Copy to system clipboard
vim.keymap.set("x", "<C-c>", '"+y')

-- Move lines up and down with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keeps cursor on the same spot on K
vim.keymap.set("n", "J", "mzJ`z")

-- Keep centered while scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "*", "*zzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Toggle commands
vim.keymap.set("n", "<leader>ts", "<cmd>set invspell<cr>", { desc = "[T]oggle [S]pell" })

-- Search and replace commands
vim.keymap.set({ "n", "x" }, "<leader>cgn", function() vim.fn.feedkeys("*Ncgn") end, { desc = "Search and change work under cursor (cgn)" })

-- Stay in visual mode after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Resize window
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +2<cr>")

-- Diagnostic keymaps
vim.keymap.set("n", "gh", vim.diagnostic.open_float, { desc = "[G]oto diagnostic [H]elp: List diagnostic under cursor" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [D]iagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostic" })
vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["ERROR"] }) end, { desc = "Previous [E]rror" })
vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["ERROR"] }) end, { desc = "Next [E]rror" })
vim.keymap.set("n", "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["WARN"] }) end, { desc = "Previous [W]arning" })
vim.keymap.set("n", "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["WARN"] }) end, { desc = "Next [W]arning" })
vim.keymap.set("n", "<leader>td", function()
	if vim.diagnostic.is_disabled() then
		vim.diagnostic.enable()
	else
		vim.diagnostic.disable()
	end
end, { desc = "Toggle diagnostics" })

local function is_quickfix_open()
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			return true
		end
	end

	return false
end

-- Quickfix
vim.keymap.set("n", "<localleader>q", function()
	if is_quickfix_open() then
		vim.cmd("cclose")
	else
		vim.cmd("botright copen")
	end
end, { desc = "[Q]uickfix toggle" })
vim.keymap.set("n", "<C-p>", function()
	if is_quickfix_open() then
		vim.cmd("cprevious")
	else
		require("telescope.builtin").find_files()
	end
end, { desc = "<C-p> Find Files" })
vim.keymap.set("n", "<C-n>", function()
	if is_quickfix_open() then
		vim.cmd("cnext")
	end
end)

vim.keymap.set("n", "<leader>zf", function()
	vim.cmd.normal("va}")
	vim.cmd.normal("zf")
end, { desc = "Create bracket {} fold [Z] [F]old" })

-- [[ Autocommands ]]
-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			timeout = 40,
		})
	end,
	group = highlight_group,
	pattern = "*",
})

-- [[ User Commands ]]
vim.api.nvim_create_user_command("Wa", "wa", { desc = "[W]rite [A]ll" })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

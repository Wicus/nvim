-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd.packadd("packer.nvim")
end

require("packer").startup(function(use)
	-- Package manager
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-treesitter/playground")

	-- LSP Configuration & Plugins
	use({
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			"j-hui/fidget.nvim",

			-- Additional lua configuration, makes nvim stuff amazing
			"folke/neodev.nvim",
		},
	})

	-- Autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"f3fora/cmp-spell",
			"saadparwaiz1/cmp_luasnip",
		},
	})

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		requires = {
			"rafamadriz/friendly-snippets",
		},
	})

	-- Highlight, edit, and navigate code
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})
	use("RRethy/vim-illuminate")

	-- Additional text objects via treesitter
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	-- Git related plugins
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("lewis6991/gitsigns.nvim")

	-- Github Copilot
	use("github/copilot.vim")

	-- Colorscheme
	use("folke/tokyonight.nvim")

	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})

	use("nvim-lualine/lualine.nvim") -- Fancier statusline
	use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
	use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically
	use("mhartington/formatter.nvim") -- Formatting
	use("tpope/vim-surround") -- Surround text objects with quotes, brackets, etc
	use("nvim-tree/nvim-tree.lua") -- File explorer
	use("ThePrimeagen/harpoon") -- Manage multiple buffers and jump between them easily

	-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
	local has_plugins, plugins = pcall(require, "custom.plugins")
	if has_plugins then
		plugins(use)
	end

	if is_bootstrap then
		require("packer").sync()
	end
end)

-- When we are bootstrapping a configuration, it doesn"t
-- make sense to execute the rest of the init.lua.
--
-- You"ll need to restart nvim, and then it will work.
if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Enable break indent
vim.o.breakindent = true

-- Disable backup files
vim.o.backup = false
vim.o.swapfile = false

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 50
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.background = "dark"
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Highlight current linenumber
vim.o.cursorline = true

-- Color column
vim.o.colorcolumn = "80"

-- Spelling
vim.o.spell = true
vim.o.spellinglang = "en_us"

-- Colorscheme setup
require("tokyonight").setup({
	styles = {
		floats = "normal",
	},
	lualine_bold = true,
	on_highlights = function(hl, colors)
		local selectionColor = "#3b4261"
		hl.IlluminatedWord = { bg = selectionColor }
		hl.IlluminatedCurWord = { bg = selectionColor }
		hl.IlluminatedWordText = { bg = selectionColor }
		hl.IlluminatedWordRead = { bg = selectionColor }
		hl.IlluminatedWordWrite = { bg = selectionColor }
		hl.FloatBorder = { fg = colors.fg_gutter }
		hl.TeleScopeBorder = { fg = colors.fg_gutter }
	end,
	on_colors = function(colors)
		---@diagnostic disable-next-line: assign-type-mismatch
		colors.gitSigns.add = colors.green
		---@diagnostic disable-next-line: assign-type-mismatch
		colors.gitSigns.change = colors.orange
		colors.gitSigns.delete = colors.red1
	end,
})

vim.cmd.colorscheme("tokyonight-night")

-- Set border for floating windows
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, { border = "single" })
vim.diagnostic.config({ float = { border = "single" } })

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- Remapping for better yank and paste
vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

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

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- File tree navigation
vim.keymap.set("n", "<leader>ft", require("nvim-tree.api").tree.toggle, { desc = "[F]ile [T]ree" })

-- Buffer commands
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { desc = "[B]uffer [D]elete" })
vim.keymap.set("n", "<leader>bp", vim.cmd.bprevious, { desc = "[B]uffer [P]revious" })
vim.keymap.set("n", "<leader>bn", vim.cmd.bnext, { desc = "[B]uffer [N]ext" })

-- Format
vim.keymap.set("n", "<leader>==", vim.cmd.Format, { desc = "[==] Format" })

-- Harpoon keymaps
vim.keymap.set("n", "<leader>fa", require("harpoon.mark").add_file, { desc = "[F]ile [A]dd: Harpoon add file" })
vim.keymap.set("n", "<leader>0", require("harpoon.ui").toggle_quick_menu, { desc = "[0] Harpoon quick menu" })

vim.keymap.set("n", "<leader>1", function()
	require("harpoon.ui").nav_file(1)
end, { desc = "[1] Harpoon goto file 1" })
vim.keymap.set("n", "<leader>2", function()
	require("harpoon.ui").nav_file(2)
end, { desc = "[2] Harpoon goto file 2" })
vim.keymap.set("n", "<leader>3", function()
	require("harpoon.ui").nav_file(3)
end, { desc = "[3] Harpoon goto file 3" })
vim.keymap.set("n", "<leader>4", function()
	require("harpoon.ui").nav_file(4)
end, { desc = "[4] Harpoon goto file 4" })

-- Toggle commands
vim.keymap.set("n", "<leader>th", vim.cmd.IlluminateToggle, { desc = "[T]oggle [H]ighlight" })

-- Close quickfix window
vim.keymap.set("n", "<leader>qq", vim.cmd.cclose, { desc = "[Q][Q]uickfix close" })

-- Search and replace commands
vim.keymap.set(
	"n",
	"<leader>sr",
	":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ desc = "[S]earch and [R]eplace in buffer" }
)
vim.keymap.set("v", "<leader>sr", ":s///gI<Left><Left><Left><Left>", { desc = "[S]earch and [R]eplace in visual mode" })

vim.keymap.set(
	"n",
	"<leader>sl",
	":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ desc = "[S]earch and replace [l]" }
)
vim.keymap.set(
	"n",
	"<leader>sq",
	":cdo s/\\<<C-r><C-w>\\>/<C-r><C-w>/gc<Left><Left><Left>",
	{ desc = "[S]earch and replace in [Q]uickfix" }
)

-- [[ Highlight on yank ]]
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

-- Set lualine as statusline
-- See `:help lualine.txt`
require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "tokyonight",
		component_separators = "|",
		section_separators = "",
	},
})

-- Enable Comment.nvim
require("Comment").setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require("indent_blankline").setup({
	char = "┊",
	show_trailing_blankline_indent = false,
})

-- Gitsigns
-- See `:help gitsigns.txt`
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<esc>"] = require("telescope.actions").close,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set(
	"n",
	"<leader>fr",
	require("telescope.builtin").oldfiles,
	{ desc = "[F]ile [R]ecent: Find recently opened files" }
)
vim.keymap.set(
	"n",
	"<leader>bb",
	require("telescope.builtin").buffers,
	{ desc = "[B]uffers [B]uffers: Find existing buffers" }
)
vim.keymap.set("n", "<leader>ss", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[S]earch [S]earch: Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>/", function()
	require("telescope.builtin").live_grep({
		glob_pattern = {
			"!src/shared/dygraphs/**",
			"!src/shared/canvas-gauges/**",
		},
	})
end, { desc = "[/]: Search in project" })

vim.keymap.set(
	"n",
	"<leader>*",
	require("telescope.builtin").grep_string,
	{ desc = "[*]: Search current word in project" }
)
vim.keymap.set(
	"v",
	"<leader>*",
	require("telescope.builtin").grep_string,
	{ desc = "[*]: Search current word in project" }
)

vim.keymap.set("n", "<leader>pf", require("telescope.builtin").find_files, { desc = "[P]roject [F]iles" })
vim.keymap.set(
	"n",
	"<leader><space>",
	require("telescope.builtin").help_tags,
	{ desc = "[ ]: Open neovim command help" }
)
vim.keymap.set("n", "<leader>rl", require("telescope.builtin").resume, { desc = "[R]esume [L]ast search" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>el", require("telescope.builtin").diagnostics, { desc = "[E]rror [L]ist [T]elescope" })
vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float, { desc = "[E]rror [L]ist [.]: List error under cursor" })
vim.keymap.set("n", "<leader>eq", vim.diagnostic.setloclist, { desc = "[E]rror [L]ist [Q]uickfix" })

vim.keymap.set("n", "[e", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, { desc = "[E]rror [P]revious" })

vim.keymap.set("n", "]e", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, { desc = "[E]rror [N]ext" })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = { "c", "cpp", "lua", "python", "typescript", "tsx", "help", "markdown" },

	highlight = { enable = true },
	indent = { enable = true, disable = { "python" } },
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

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don"t have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>br", vim.lsp.buf.rename, "[B]uffer [R]ename")

	nmap("<leader>sj", require("telescope.builtin").lsp_document_symbols, "[S]ymbols [J]ump: Document symbols")
	nmap(
		"<leader>sp",
		require("telescope.builtin").lsp_dynamic_workspace_symbols,
		"[S]ymbols [P]roject: Workspace symbols"
	)

	nmap("<localleader>r.", vim.lsp.buf.code_action, "[R]efactor: Code Actions")
	nmap("<localleader>rr", vim.lsp.buf.rename, "[R]efactor [R]ename")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("<localleader>gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("<localleader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<localleader>gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

	nmap("<localleader>gt", vim.lsp.buf.type_definition, "[G]oto [T]ype definition")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "[K]: Hover Documentation")
	nmap("gh", vim.lsp.buf.signature_help, "[G]oto [H]elp: Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<localleader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

	nmap("<leader>pa", vim.lsp.buf.add_workspace_folder, "[P]roject [A]dd: Workspace add folder")
	nmap("<leader>pd", vim.lsp.buf.remove_workspace_folder, "[P]roject [x] delete folder: Workspace remove folder")
	nmap("<leader>pl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[P]roject [L]ist folders: Workspace list folders")

	-- Create a command `:Format` local to the LSP buffer
	-- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
	--   vim.lsp.buf.format()
	-- end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	-- clangd = {},
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	tsserver = {},
	eslint = {},
	sumneko_lua = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- Setup neovim lua configuration
require("neodev").setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

-- Turn on lsp status information
require("fidget").setup()

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered({
			border = "single",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
		}),
		documentation = cmp.config.window.bordered({
			border = "single",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
		}),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<C-n>"] = cmp.mapping.complete({}),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "spell" },
	},
})

-- Snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Formatter setup
require("formatter").setup({
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettierd,
		},
		typescriptreact = {
			require("formatter.filetypes.typescriptreact").prettierd,
		},
	},
})

-- Format on save autocommand
local formatting_group = vim.api.nvim_create_augroup("FormattingGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "FormatWriteLock",
	group = formatting_group,
	pattern = { "*.tsx", "*.ts", "*.lua" },
})

-- Nvim tree setup
require("nvim-tree").setup({
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	renderer = {
		highlight_opened_files = "all",
		root_folder_modifier = ":t",
		icons = {
			show = {
				file = false,
				folder = false,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				git = {
					unstaged = "~",
					renamed = "_",
					untracked = "+",
					deleted = "-",
					unmerged = "",
					staged = "",
					ignored = "",
				},
				folder = {
					arrow_open = "v",
					arrow_closed = ">",
				},
			},
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		debounce_delay = 250,
		icons = {
			hint = "H",
			info = "I",
			warning = "W",
			error = "E",
		},
	},
	view = {
		adaptive_size = true,
		side = "left",
		mappings = {
			list = {
				{ key = "l", action = "edit" },
				{ key = "h", action = "close_node" },
				{ key = "v", action = "vsplit" },
			},
		},
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})

-- Illuminate setup
require("illuminate").configure({
	delay = 500,
	min_count_to_highlight = 2,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

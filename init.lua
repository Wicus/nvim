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
	use("nvim-tree/nvim-web-devicons")

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

			-- OmniSharp extended LSP
			"Hoffs/omnisharp-extended-lsp.nvim",
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

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- Github Copilot
	use("github/copilot.vim")

	-- Colorschemes
	-- use("folke/tokyonight.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})

	-- NeoTree
	-- Unless you are still migrating, remove the deprecated commands from v1.x
	vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
	})

	use("mbbill/undotree") -- Undo tree
	use("nvim-lualine/lualine.nvim") -- Fancier statusline
	use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
	use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically
	use("mhartington/formatter.nvim") -- Formatting
	use("tpope/vim-surround") -- Surround text objects with quotes, brackets, etc
	use("ThePrimeagen/harpoon") -- Manage multiple buffers and jump between them easily
	use("folke/zen-mode.nvim") -- Distraction free mode
	use("Vonr/align.nvim") -- A minimal plugin for aligning lines
	use("norcalli/nvim-colorizer.lua") -- Highlight color codes in files
	use("nvim-pack/nvim-spectre") -- A code search and replace tool
	use({
		"folke/which-key.nvim",
		config = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 300
			require("which-key").setup({})
		end,
	})

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
-- See `:help vim.opt`

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.copilot_filetypes = { TelescopePrompt = false }

-- Sane defaults for tabs and spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set highlight on search
vim.opt.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.opt.relativenumber = true

-- Enable break indent
vim.opt.breakindent = true

-- Disable backup files
vim.opt.backup = true
vim.opt.backupdir = "C:\\Users\\Wicus Pretorius\\nvim-backup-folder"
vim.opt.swapfile = true
vim.opt.directory = "C:\\Users\\Wicus Pretorius\\nvim-swap-folder"

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
vim.opt.completeopt = "menuone,noselect"

-- Highlight current linenumber
vim.opt.cursorline = true

-- Color column
vim.opt.colorcolumn = "120"

-- Spelling
vim.opt.spell = false
vim.opt.spelllang = "en_us"

-- Clipboard
-- vim.opt.clipboard = "unnamedplus"

-- Always show the signcolumn, otherwise it would shift the text each time
vim.wo.signcolumn = "yes"

-- We don't need to see things like -- INSERT -- anymore
vim.opt.showmode = false

-- Better splits when opening buffers
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set guifont
vim.opt.guifont = "Consolas:h9"

vim.opt.wrap = false

-- Disable NetRw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Linux line endings
vim.opt.fileformats = "unix"

-- Colorscheme setup
-- require("tokyonight").setup({
-- 	style = "night",
-- 	styles = {
-- 		floats = "normal",
-- 	},
-- 	lualine_bold = true,
-- 	on_highlights = function(hl, colors)
-- 		hl.FloatBorder = { fg = colors.fg_gutter }
-- 		hl.TeleScopeBorder = { fg = colors.fg_gutter }
-- 		hl.TeleScopeTitle = { fg = colors.fg }
-- 		hl.NeoTreeFloatNormal = { bg = colors.bg_dark }
-- 		hl.NeoTreeFloatBorder = { bg = colors.bg_dark, fg = colors.fg_gutter }
-- 		hl.NeoTreeGitUntracked = { fg = colors.green }
-- 		hl.NeoTreeModified = { fg = colors.fg }
-- 		hl.NeoTreeExpander = { fg = colors.fg }
-- 	end,
-- 	on_colors = function(colors)
-- 		colors.gitSigns.add = colors.green
-- 		colors.gitSigns.change = colors.orange
-- 		colors.gitSigns.delete = colors.red1
-- 	end,
-- })

require("catppuccin").setup({
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
	custom_highlights = {},
	integrations = {
		cmp = true,
		gitsigns = true,
		neotree = true,
		telescope = true,
		illuminate = true,
		mason = true,
		markdown = true,
		harpoon = true,
		which_key = true,
	},
})

vim.cmd.colorscheme("catppuccin")

-- Set border for floating windows
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers["textDocument/hover"], { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["textDocument/signatureHelp"], { border = "single" })
vim.diagnostic.config({ float = { border = "single" } })

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- Pasting will not replace the current register with what is selected
vim.keymap.set("x", "p", '"_dP')

-- Copy to system clipboard
vim.keymap.set("x", "<C-c>", '"+y')

-- Cut to system clipboard
vim.keymap.set("x", "<C-x>", '"+yD')

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

-- File tree navigation
vim.keymap.set("n", "<leader>ft", function()
	vim.cmd("Neotree toggle")
end, { desc = "[F]ile [T]ree" })
vim.keymap.set("n", "<leader>e", function()
	vim.cmd("Neotree toggle")
end, { desc = "[E]xplorer (Neotree) toggle" })

-- Buffer commands
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { desc = "[B]uffer [D]elete" })
vim.keymap.set("n", "[b", vim.cmd.bprevious, { desc = "[B]uffer [P]revious" })
vim.keymap.set("n", "]b", vim.cmd.bnext, { desc = "[B]uffer [N]ext" })

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
vim.keymap.set("n", "<leader>5", function()
	require("harpoon.ui").nav_file(5)
end, { desc = "[5] Harpoon goto file 5" })

-- Toggle commands
vim.keymap.set("n", "<leader>ti", vim.cmd.IlluminateToggle, { desc = "[T]oggle [I]lluminate" })
vim.keymap.set("n", "<leader>ts", function()
	vim.cmd.set("invspell")
end, { desc = "[T]oggle [S]pell" })
vim.keymap.set("n", "<leader>th", function()
	vim.opt.hlsearch = not vim.opt.hlsearch:get()
end, { desc = "[T]oggle [H]ighlight search" })

-- Search and replace commands
vim.keymap.set("n", "<leader>sa", "/\\<\\><Left><Left>", { desc = "[S]earch [A]round word in buffer" })
vim.keymap.set("n", "<leader>se", ":%s//gcI<Left><Left><Left><Left>", { desc = "[S]earch and [E]dit in buffer" })
vim.keymap.set("n", "<leader>sq", ":cdo s//gcI<Left><Left><Left><Left>", { desc = "[S]earch and edit in [Q]uickfix" })
vim.keymap.set("n", "<leader>sr", require("spectre").open, { desc = "[S]earch and [R]eplace" })

-- Quickfix
vim.keymap.set("n", "[f", "<cmd>cprevious<cr>zz")
vim.keymap.set("n", "]f", "<cmd>cnext<cr>zz")

-- Location list
vim.keymap.set("n", "[s", vim.cmd.lprevious)
vim.keymap.set("n", "]s", vim.cmd.lnext)

-- Stay in visual mode after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<leader>zm", vim.cmd.ZenMode, { desc = "[Z]en [M]ode Toggle" })

vim.keymap.set("n", "<leader>ff", vim.cmd.FormatWriteLock, { desc = "[F]ormat buffer" })
vim.keymap.set("v", "<leader>ff", vim.cmd.FormatWriteLock, { desc = "[F]ormat buffer" })

-- Resize window
vim.keymap.set("n", "<C-Up>", function()
	vim.cmd.resize("+2")
end)
vim.keymap.set("n", "<C-Down>", function()
	vim.cmd.resize("-2")
end)
vim.keymap.set("n", "<C-Left>", function()
	vim.cmd("vertical resize -2")
end)
vim.keymap.set("n", "<C-Right>", function()
	vim.cmd("vertical resize +2")
end)

vim.keymap.set("n", "<leader>q", function()
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			vim.cmd.cclose()
			return
		end
	end

	vim.cmd.copen()
end, { desc = "[Q]uickfix toggle" })

vim.keymap.set("n", "<leader>zf", function()
	vim.cmd.normal("va}")
	vim.cmd.normal("zf")
end, { desc = "Create bracket {} fold [Z] [F]old" })
-- Align commands
-- Aligns to a string, looking left and with previews
vim.keymap.set("x", "aw", function()
	require("align").align_to_string(false, true, true)
end)
-- What does this do? Remove
vim.keymap.set("n", "<leader>aw", function()
	require("align").operator(require("align").align_to_string, { is_pattern = false, reverse = true, preview = true })
end, { desc = "[A]lign [W]ith" })

vim.keymap.set("n", "<leader>wa", vim.cmd.wa, { desc = "[W]rite [A]ll" })
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndo tree" })

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

-- Format on save autocommand
local formatting_group = vim.api.nvim_create_augroup("FormattingGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "FormatWriteLock",
	group = formatting_group,
	pattern = {
		"*.tsx",
		"*.ts", --[[ "*.jsx", "*.js", ]]
		"*.lua",
		"*.cs",
		"*.cpp",
		"*.hpp",
		"*.json",
	},
})

vim.api.nvim_create_user_command("Dark", function(_)
	vim.cmd.highlight("Normal guibg=none")
	vim.cmd.highlight("NormalFloat guibg=none")
end, { desc = "Dark background" })

-- Set lualine as statusline
-- See `:help lualine.txt`
require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "catppuccin",
		component_separators = "|",
		section_separators = "",
		disabled_filetypes = {
			"neo-tree",
		},
	},
	winbar = {
		lualine_c = { { "filename", path = 1 } },
	},
	inactive_winbar = {
		lualine_c = { { "filename", path = 1 } },
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
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		vim.keymap.set("n", "]g", function()
			if vim.wo.diff then
				return "]g"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		vim.keymap.set("n", "[g", function()
			if vim.wo.diff then
				return "[g"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		vim.keymap.set("n", "<leader>gp", gs.preview_hunk)
		vim.keymap.set("n", "<leader>gr", gs.reset_hunk)
		vim.keymap.set("n", "<leader>gR", gs.reset_buffer)
		vim.keymap.set("n", "<leader>gs", gs.diffthis)
	end,
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				-- ["<C-p>"] = require("telescope.actions").cycle_history_prev,
				-- ["<C-n>"] = require("telescope.actions").cycle_history_next,
			},
		},
		path_display = { "truncate" },
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>fr", function()
	require("telescope.builtin").oldfiles({ cwd_only = true })
end, { desc = "[F]ile [R]ecent: Find recently opened files" })

vim.keymap.set("n", "<leader>bb", require("telescope.builtin").buffers, { desc = "[B]uffers [B]uffers: Find existing buffers" })
vim.keymap.set("n", "<leader>ss", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[S]earch [S]earch: Fuzzily search in current buffer" })

local glob_pattern = {
	"!src/shared/dygraphs/**",
	"!src/shared/canvas-gauges/**",
}

vim.keymap.set("n", "<leader>/", function()
	require("telescope.builtin").live_grep({
		glob_pattern = glob_pattern,
	})
end, { desc = "[/]: Search in project" })

local function getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

vim.keymap.set("n", "<leader>*", require("telescope.builtin").grep_string, { desc = "[*]: Search current word in project" })
vim.keymap.set("v", "<leader>*", function()
	require("telescope.builtin").live_grep({ default_text = getVisualSelection(), glob_pattern = glob_pattern })
end, { desc = "[*]: Search current word in project" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sG", require("telescope.builtin").git_files, { desc = "[S]earch [G]it files" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").git_status, { desc = "[S]earch [G]it status" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").commands, { desc = "[ ]: Open neovim commands" })
vim.keymap.set("n", "<leader>sl", require("telescope.builtin").resume, { desc = "Resume [S]earch [L]ist" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "[D]iagnostic [L]ist" })
vim.keymap.set("n", "gh", vim.diagnostic.open_float, { desc = "[G]oto diagnostic [H]elp: List diagnostic under cursor" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [D]iagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostic" })
vim.keymap.set("n", "[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["ERROR"] })
end, { desc = "Previous [E]rror" })
vim.keymap.set("n", "]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["ERROR"] })
end, { desc = "Next [E]rror" })
vim.keymap.set("n", "[w", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["WARN"] })
end, { desc = "Previous [W]arning" })
vim.keymap.set("n", "]w", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["WARN"] })
end, { desc = "Next [W]arning" })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		-- Web development
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"json",
		-- General development
		"c",
		"cpp",
		"c_sharp",
		"python",
		-- Neovim
		"lua",
		"vim",
		-- Other
		"help",
		"markdown",
		"markdown_inline",
	},

	highlight = {
		enable = true,
		disable = function(_, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},
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
local on_attach = function(client, bufnr)
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

	local imap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("i", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>nr", vim.lsp.buf.rename, "[B]uffer [R]ename")

	nmap("<leader>sj", require("telescope.builtin").lsp_document_symbols, "[S]ymbols [J]ump: Document symbols")
	nmap("<leader>sw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[S]ymbols [W]orkspace: Workspace symbols")

	nmap("<localleader>r.", vim.lsp.buf.code_action, "[R]efactor: Code Actions")
	nmap("<localleader>rr", vim.lsp.buf.rename, "[R]efactor [R]ename")

	-- nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	nmap("<localleader>gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("<localleader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

	nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	nmap("<localleader>gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

	nmap("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype definition")
	nmap("<localleader>gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype definition")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("gK", vim.lsp.buf.signature_help, "Signature Help")
	imap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<localleader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

	nmap("<leader>pa", vim.lsp.buf.add_workspace_folder, "[P]roject [A]dd: Workspace add folder")
	nmap("<leader>pd", vim.lsp.buf.remove_workspace_folder, "[P]roject [x] delete folder: Workspace remove folder")
	nmap("<leader>pl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[P]roject [L]ist folders: Workspace list folders")

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })

	-- Hack for omnisharp
	if client.name == "omnisharp" then
		client.server_capabilities.semanticTokensProvider = {
			full = vim.empty_dict(),
			legend = {
				tokenModifiers = { "static_symbol" },
				tokenTypes = {
					"comment",
					"excluded_code",
					"identifier",
					"keyword",
					"keyword_control",
					"number",
					"operator",
					"operator_overloaded",
					"preprocessor_keyword",
					"string",
					"whitespace",
					"text",
					"static_symbol",
					"preprocessor_text",
					"punctuation",
					"string_verbatim",
					"string_escape_character",
					"class_name",
					"delegate_name",
					"enum_name",
					"interface_name",
					"module_name",
					"struct_name",
					"type_parameter_name",
					"field_name",
					"enum_member_name",
					"constant_name",
					"local_name",
					"parameter_name",
					"method_name",
					"extension_method_name",
					"property_name",
					"event_name",
					"namespace_name",
					"label_name",
					"xml_doc_comment_attribute_name",
					"xml_doc_comment_attribute_quotes",
					"xml_doc_comment_attribute_value",
					"xml_doc_comment_cdata_section",
					"xml_doc_comment_comment",
					"xml_doc_comment_delimiter",
					"xml_doc_comment_entity_reference",
					"xml_doc_comment_name",
					"xml_doc_comment_processing_instruction",
					"xml_doc_comment_text",
					"xml_literal_attribute_name",
					"xml_literal_attribute_quotes",
					"xml_literal_attribute_value",
					"xml_literal_cdata_section",
					"xml_literal_comment",
					"xml_literal_delimiter",
					"xml_literal_embedded_expression",
					"xml_literal_entity_reference",
					"xml_literal_name",
					"xml_literal_processing_instruction",
					"xml_literal_text",
					"regex_comment",
					"regex_character_class",
					"regex_anchor",
					"regex_quantifier",
					"regex_grouping",
					"regex_alternation",
					"regex_text",
					"regex_self_escaped_character",
					"regex_other_escape",
				},
			},
			range = true,
		}
	end
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	lua_ls = {
		settings = {
			Lua = {
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
			},
		},
	},
	tsserver = {},
	eslint = {},
	clangd = {
		capabilities = {
			offsetEncoding = { "utf-16" },
		},
	},
	pyright = {},
	omnisharp = {
		cmd = { "cmd", "/c", "omnisharp" },
		handlers = { ["textDocument/definition"] = require("omnisharp_extended").handler },
	},
	jsonls = {},

	-- gopls = {},
	-- rust_analyzer = {},
}

-- Setup neovim lua configuration
require("neodev").setup()

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
		local setup = {
			capabilities = capabilities,
			on_attach = on_attach,
		}
		local server_settings = servers[server_name]

		setup = vim.tbl_deep_extend("force", setup, server_settings)

		require("lspconfig")[server_name].setup(setup)
	end,
})

-- Turn on lsp status information
require("fidget").setup()

-- nvim-cmp setup
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
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
			local label = vim_item.abbr
			local truncated_label = vim.fn.strcharpart(label, 0, 50)
			if truncated_label ~= vim_item.abbr then
				vim_item.abbr = truncated_label .. "..."
			end
			return vim_item
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<C-l>"] = cmp.mapping.complete({}),
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
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "spell" },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp_signature_help" },
	},
})

-- Snippets
require("luasnip.loaders.from_vscode").lazy_load()

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
	},
})

-- Illuminate setup
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

-- Zen mode setup
require("zen-mode").setup({
	window = {
		width = 140,
	},
})

-- Colorizer setup
require("colorizer").setup()

-- NeoTree setup
require("neo-tree").setup({
	hide_root_node = true,
	close_if_last_window = true,
	retain_hidden_root_indent = false,
	popup_border_style = "single",
	close_floats_on_escape_key = false,
	use_popups_for_input = false,
	default_component_configs = {
		git_status = {
			symbols = {
				-- -- Change type
				added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "-", -- this can only be used in the git_status source
				renamed = "_", -- this can only be used in the git_status source
				-- Status type
				unstaged = "",
				untracked = "+",
				ignored = "",
				staged = "",
				conflict = "",
			},
		},
	},
	window = {
		mappings = {
			["l"] = "open",
			["h"] = "close_node",
			["v"] = "open_vsplit",
		},
		auto_expand_width = true,
	},
	filesystem = {
		follow_current_file = true,
		use_libuv_file_watcher = true,
		filtered_items = {
			hide_by_name = {
				"node_modules",
			},
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

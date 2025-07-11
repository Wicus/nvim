return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"jbyuki/one-small-step-for-vimkind",
		},
		keys = {
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
			{ "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
			-- { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
			{ "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
			{ "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
			{ "<leader>dj", function() require("dap").down() end, desc = "Down" },
			{ "<leader>dk", function() require("dap").up() end, desc = "Up" },
			{ "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
			{ "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
			{ "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
			{ "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
			{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
			{ "<leader>ds", function() require("dap").session() end, desc = "Session" },
			{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
			{ "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
			{ "<F5>", function() require("dap").continue() end, desc = "Start/Continue Debugging" },
			{ "<F6>", function() require("osv").launch({ port = 8086 }) end, desc = "Launch lua OSV server" },
			{ "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
			{ "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
			{ "<S-F11>", function() require("dap").step_out() end, desc = "Step Out" },
		},
		config = function()
			local dap = require("dap")
			require("nvim-dap-virtual-text").setup()

			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
			vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" })
			vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticWarn" })
			vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError" })
			vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo" })

			dap.adapters.coreclr = {
				type = "executable",
				command = vim.fn.exepath("netcoredbg"),
				args = { "--interpreter=vscode" },
				options = {
					detached = false,
				},
			}

			dap.adapters.nlua = function(callback, config) callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }) end
			dap.configurations.lua = {
				{
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance",
				},
			}

			vim.cmd([[set noshellslash]])
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio", "folke/lazydev.nvim", "folke/snacks.nvim" },
		keys = {
			{ "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
			{ "gK", function() require("dapui").eval() end, desc = "DAP Eval", mode = { "n", "v" } },
			{ "gL", function() require("dap").run_to_cursor() end, desc = "Run to Cursor (Line)" },
		},
		opts = {
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.25,
						},
						{
							id = "watches",
							size = 0.25,
						},
						{
							id = "stacks",
							size = 0.25,
						},
						{
							id = "breakpoints",
							size = 0.25,
						},
					},
					position = "left",
					size = 80,
				},
				{
					elements = {
						{
							id = "repl",
							size = 1,
						},
						-- I don't know what this actually does (in C# this does not do anything)
						-- {
						-- 	id = "console",
						-- 	size = 0.5,
						-- },
					},
					position = "bottom",
					size = 20,
				},
			},
		},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")

			local function open_handler()
				local explorer_picker = require("snacks.picker").get({ source = "explorer" })
				if explorer_picker and explorer_picker[1] then
					explorer_picker[1]:close()
				end
				dapui.open()
			end

			local function close_handler() dapui.close() end

			dap.listeners.before.attach.dapui_config = open_handler
			dap.listeners.before.launch.dapui_config = open_handler
			dap.listeners.before.event_terminated.dapui_config = close_handler
			dap.listeners.before.event_exited.dapui_config = close_handler

			dapui.setup(opts)

			require("lazydev").setup({
				library = { "nvim-dap-ui" },
			})
		end,
	},
}

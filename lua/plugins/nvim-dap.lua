return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
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
			{ "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
			{ "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
			{ "<S-F11>", function() require("dap").step_out() end, desc = "Step Out" },
		},
		config = function()
			local dap = require("dap")

			dap.adapters.coreclr = {
				type = "executable",
				command = "netcoredbg",
				args = { "--interpreter=vscode" },
			}

			-- setup dap config by VsCode launch.json file
			local vscode = require("dap.ext.vscode")
			local json = require("plenary.json")
			vscode.json_decode = function(str) return vim.json.decode(json.json_strip_comments(str)) end

			vim.cmd([[set noshellslash]])

			-- Example configuration for C# debugging
			-- dap.configurations.cs = {
			-- 	{
			-- 		type = "coreclr",
			-- 		name = "launch - netcoredbg",
			-- 		request = "launch",
			-- 		program = function() return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file") end,
			-- 	},
			-- }
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio", "folke/lazydev.nvim" },
		keys = {
			{ "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
			{ "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
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
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
			dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
			dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end

			require("lazydev").setup({
				library = { "nvim-dap-ui" },
			})

			-- dap.listeners.before.attach.dapui_config = function() dapui.open() end
			-- dap.listeners.before.launch.dapui_config = function() dapui.open() end
			-- dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			-- dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
		end,
	},
}

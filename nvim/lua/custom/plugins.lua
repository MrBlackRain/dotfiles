local utils = require("custom.utils")

local python = require("custom.languages.python.config")
local ts = require("custom.languages.typescript.config")
local misc = require("custom.languages.misc.config")

local mason_ensure_installed = {
	"lua-language-server",
	"stylua",
}

vim.list_extend(mason_ensure_installed, python.mason_ensure_installed)
vim.list_extend(mason_ensure_installed, ts.mason_ensure_installed)
vim.list_extend(mason_ensure_installed, misc.mason_ensure_installed)

local treesitter_ensure_installed = {
	"lua",
	"vimdoc",
}

vim.list_extend(treesitter_ensure_installed, python.treesitter_ensure_installed)
vim.list_extend(treesitter_ensure_installed, ts.treesitter_ensure_installed)
vim.list_extend(treesitter_ensure_installed, misc.treesitter_ensure_installed)

local plugins = {
	-- Syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = treesitter_ensure_installed,
		},
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},
	-- LSP
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = mason_ensure_installed,
		},
		build = ":MasonUpdate",
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.languages.python.lsp")
			require("custom.languages.typescript.lsp")
			require("custom.languages.misc.lsp")
		end,
	},
	{
		"davidmh/cspell.nvim",
		config = function()
			require("cspell").config = { read_config_synchronously = false }
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		ft = {
			"*",
		},
		event = "VeryLazy",
		opts = function()
			return require("custom.configs.null-ls")
		end,
		dependencies = {
			"davidmh/cspell.nvim",
		},
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({})
			require("core.utils").load_mappings("lspsaga")
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
			})
		end,
	},
	-- Debbugers
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("core.utils").load_mappings("dap")
			local json5 = require("json5")
			require("dap.ext.vscode").json_decode = json5.parse
			require("dap.ext.vscode").load_launchjs()
		end,
		dependencies = "Joakker/lua-json5",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	-- DAP for languages
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local mason_registry = require("mason-registry")
			local debugpy = mason_registry.get_package("debugpy")
			local path = debugpy:get_install_path() .. "/venv/bin/python"

			require("dap-python").setup(path)
		end,
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("custom.configs.dap-vscode-js")
		end,
	},
	-- Git
	{
		"lewis6991/gitsigns.nvim",
	},
	-- lua-json5 (for dap conpatability with launch.json made in vscode)
	{
		"Joakker/lua-json5",
		build = vim.fn.stdpath("data") .. "/lazy/lua-json5/install.sh",
	},
	-- todo highlighting
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,
		config = function(_, opts)
			require("todo-comments").setup(opts)
		end,
		opts = {
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--glob=!venv",
					"--glob=!node_modules",
				},
				pattern = [[\b(KEYWORDS):]],
			},
		},
	},
}

return plugins

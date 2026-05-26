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

require("lazy").setup({
	-- Visuals
	"ellisonleao/gruvbox.nvim",

	"airblade/vim-gitgutter",
	"tpope/vim-sleuth",

	"tpope/vim-fugitive",

	"neovim/nvim-lspconfig",

	{
	 'nvim-treesitter/nvim-treesitter',
	  branch = "main",
	  lazy = false,
	  build = ':TSUpdate'
	},

	-- {
	--   "nvim-treesitter/nvim-treesitter-textobjects",
	--   branch = "main",
	--   init = function()
	--     -- Disable entire built-in ftplugin mappings to avoid conflicts.
	--     -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
	--     vim.g.no_plugin_maps = true
	-- 
	--     -- Or, disable per filetype (add as you like)
	--     -- vim.g.no_python_maps = true
	--     -- vim.g.no_ruby_maps = true
	--     -- vim.g.no_rust_maps = true
	--     -- vim.g.no_go_maps = true
	--   end,
	--   config = function()
	--     -- put your config here
	--   end,
	-- },

	-- "nvim-treesitter/playground",

	{ "j-hui/fidget.nvim", opts = {} },

	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	"dcampos/nvim-snippy",

	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",

	"nvim-lua/plenary.nvim",

	"norcalli/nvim-colorizer.lua",

	"swaits/zellij-nav.nvim",

	{
		"mrcjkb/rustaceanvim",
		version = "^9", -- Recommended
		lazy = false, -- This plugin is already lazy
	},

	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "notes",
					path = "~/notes/",
				},
			},
			completion = {
				nvim_cmp = true,
				min_chars = 1,
			},

			new_notes_location = "notes_subdir",
			notes_subdir = "00 Inbox",

			daily_notes = {
				folder = "01 Daily/" .. os.date("%Y/%m %b/"),
			},

			follow_url_func = function(url)
				vim.fn.jobstart({ "open", url })
			end,
		},
	},

	{
		"olimorris/codecompanion.nvim",
		config = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		opts = {
			adapters = {
				http = {
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							schema = {
								model = {
									default = "gemma4",
								},
							},
						})
					end,
				},
			},

			strategies = {
				chat = {
					adapter = "ollama",
				},
				inline = {
					adapter = "ollama",
				},
				cmd = {
					adapter = "ollama",
				},
			},
		},
	},

	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					svelte = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					-- This breaks markdown lists
					-- markdown = { "prettier" },
					graphql = { "prettier" },
					lua = { "stylua" },
					python = { "isort", "black" },
					sh = { "shfmt" },
					zsh = { "shfmt" },
				},
			})
		end,
	},
})

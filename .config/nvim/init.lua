vim.opt.mouse = 'a'
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- KEYBINDINGS
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})

-- space+w save
vim.keymap.set('n', '<space>w', '<cmd>write<cr>', { desc = 'Save' })
-- cp copy from clipboard
vim.keymap.set({ 'n', 'x' }, 'cp', '"+y')
-- cv paste from clipboard
vim.keymap.set({ 'n', 'x' }, 'cv', '"+p')
-- \a select all text in current buffer
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')
-- \+n toggle line numbers
vim.keymap.set('n', '<leader>n', ':set nu!<cr>')

-- lazy.nvim
local lazy = {}

function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print('Installing lazy.nvim....')
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable', -- latest stable release
			path,
		})
	end
end

function lazy.setup(plugins)
	-- You can "comment out" the line below after lazy.nvim is installed
	lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)
	require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
	{ 'folke/tokyonight.nvim' },
	{ 'nvim-lualine/lualine.nvim' }, -- Status line
	{ 'romgrk/barbar.nvim',             dependencies = 'nvim-tree/nvim-web-devicons' }, -- tabline
	{ 'ray-x/guihua.lua' },
	--- https://github.com/ray-x/go.nvim#lazynvim
	{ 'ray-x/guihua.lua' },
	{ "neovim/nvim-lspconfig" },
	{ "nvim-treesitter/nvim-treesitter" },
	-- LSP
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		dependencies = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{ 'williamboman/mason.nvim' }, -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'hrsh7th/cmp-buffer' }, -- Optional
			{ 'hrsh7th/cmp-path' }, -- Optional
			{ 'saadparwaiz1/cmp_luasnip' }, -- Optional
			{ 'hrsh7th/cmp-nvim-lua' }, -- Optional

			-- Snippets
			{ 'L3MON4D3/LuaSnip' }, -- Required
			{ 'rafamadriz/friendly-snippets' }, -- Optional
		}
	},
	{
		"ray-x/go.nvim",
		requires = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = true,
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", 'gomod' },
		build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
	},
	{
		'ray-x/navigator.lua',
		requires = {
			"ray-x/guihua.lua",
			"neovim/nvm-lspconfig",
		},
		config = function()
			require("navigator").setup()
		end
	},
	{
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require("nvim-tree").setup()
		end
	}
})

-- COLORSCHEME
vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight')

-- configure lualine
require('lualine').setup()

-- configure lsp-zero
local lsp = require('lsp-zero').preset({
	name = 'minimal',
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
	suggest_lsp_servers = true,
	setup_servers_on_start = true,
})

lsp.nvim_workspace()

lsp.setup()

-- configure go.nvim
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require('go.format').goimport()
	end,
	group = format_sync_grp,
})

require('go').setup()

local lazy = {}

local vim = vim -- Ignores local warning
vim.opt.number = true
vim.opt.hlsearch = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.expandtab = false
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.showmode = false
vim.o.cmdheight = 0
vim.diagnostic.config({ virtual_text = false })
vim.o.swapfile = false
vim.o.wrap = false
vim.o.winborder = "rounded"


function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print('Installing lazy.nvim....')
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable',
			path,
		})
	end
end

function lazy.setup(plugins)
	if vim.g.plugins_ready then
		return
	end

	lazy.install(lazy.path)
	vim.opt.rtp:prepend(lazy.path)

	require('lazy').setup(plugins, lazy.opts)
	vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

-- call lazy.setup() properly here
lazy.setup({
	{ "nvim-lualine/lualine.nvim" },
	{
		"vimwiki/vimwiki",
		init = function()
			vim.g.vimwiki_list = {
				{
					path = '~$HOME/Documents/vimwiki',
					syntax = 'markdown',
					ext = '.md',
				},
			}
		end,
		config = function()
			-- Dracula custom highlights for Vimwiki
			vim.cmd [[
      augroup VimwikiDracula
        autocmd!
        autocmd FileType vimwiki highlight VimwikiLink guifg=#bd93f9 gui=underline
        autocmd FileType vimwiki highlight VimwikiHeader1 guifg=#ff79c6 gui=bold
        autocmd FileType vimwiki highlight VimwikiHeader2 guifg=#ff79c6 gui=bold
        autocmd FileType vimwiki highlight VimwikiHeader3 guifg=#ff79c6 gui=bold
      augroup END
    ]]
		end
	},
	{ "Mofiqul/dracula.nvim",           priority = 1000 },
	{ "nvim-treesitter/nvim-treesitter" },
	{
		'nvim-telescope/telescope.nvim',
		tag = 'v0.2.0',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ "mason-org/mason.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "mason-org/mason-lspconfig.nvim" },
	-- {"nvim-cmp"},
	-- {""},
	-- {""},
	-- {""},
	-- {""},

})

-- Setup for mason
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})


require("mason-lspconfig").setup({
	ensure_installed = { 'pyright', 'lua_ls' }
})


-- Lsp settings
vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')

--
--
local builtin = require('telescope.builtin')

-- Telescope bindings
-- vim.keymap.set( mode, keymap, function to call)
-- Searches for files. Use instead of vimtree
vim.keymap.set('n', '<leader>ff', builtin.find_files)
-- Search previously opened files
vim.keymap.set('n', '<leader>fp', builtin.oldfiles)
-- Search files commited in git
vim.keymap.set('n', '<leader>fg', builtin.git_files)
-- Search git commits
vim.keymap.set('n', '<leader>fc', builtin.git_commits)
-- Grep for string in all files
vim.keymap.set('n', '<leader>fs', builtin.live_grep)

-- Format file with lsp
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- these should stay AFTER lazy.setup
require("lualine").setup()
vim.cmd [[colorscheme dracula]]

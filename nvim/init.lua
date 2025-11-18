local lazy={}
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
  {"nvim-lualine/lualine.nvim"},
  {"vimwiki/vimwiki", 
    init = function() 
      vim.g.vimwiki_list = {
        {
					path='~/vimwiki',
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
  {"Mofiqul/dracula.nvim", priority = 1000},
  {"nvim-treesitter/nvim-treesitter"},
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
			vim.keymap.set('n', '<leader>d', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end,
  }
})


-- these should stay AFTER lazy.setup
require("lualine").setup()
vim.cmd[[colorscheme dracula]]


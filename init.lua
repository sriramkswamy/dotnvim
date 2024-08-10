-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath_root = vim.fn.stdpath("data")
local lazypath = lazypath_root .. 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Import all the plugins configurations from lua/plugins/*.lua
require('lazy').setup({
  { import = 'plugins' },
}, {})

-- Set up some sensible options
require('options')

-- Set up basic keymaps
require('keymaps')

-- Load custom functions
require('functions')

-- Wrap up the LSP settings
require('lsp')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

return {
  { -- git interface within vim
    'tpope/vim-fugitive',
    keys = {
      { '<leader>e', ':Git<CR>', desc = 'Fugitive Status' },
    }
  }
}

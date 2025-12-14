return {
  { -- git interface within vim
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'Gdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'GMove', 'GDelete', 'GBrowse', 'GRemove', 'GRename', 'Glgrep', 'Gedit' },
    keys = {
      { '<leader>e', ':Git<CR>', desc = 'Git Status' },
      { '<leader>gb', ':Git blame<CR>', desc = 'Git Blame' },
    }
  },

  { -- file history and revisions
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gh', mode = {"n"}, ":DiffviewFileHistory %<CR>", desc = 'Git File History' },
      { '<leader>gh', mode = {"x"}, ":DiffviewFileHistory<CR>", desc = 'Git File History' },
    },
  }
}

return {
  { -- git interface within vim
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'Gdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'GMove', 'GDelete', 'GBrowse', 'GRemove', 'GRename', 'Glgrep', 'Gedit' },
    keys = {
      { '<leader>e', ':Git<CR>', desc = 'Git Status' },
      { '<leader>ga', ':Git log --oneline -100<CR>', desc = 'Git Oneline Log' },
      { '<leader>gb', mode = {"n","x"}, ':Git blame<CR>', desc = 'Git Blame' },
      { '<leader>gw', mode = {"n"}, 'V:Git blame<CR>', desc = 'Git Blame Line' },
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

return {

  { -- undo tree
    'mbbill/undotree',
    keys = {
      { '<leader>U', '<cmd>UndotreeToggle<cr>', 'n', silent = true, desc = 'undo tree' }
    }
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- extend repeat
  'tpope/vim-repeat',

  { -- "gc/gb" to comment visual regions/lines
    'numToStr/Comment.nvim',
    config = function ()
      require('Comment').setup({
        ---LHS of toggle mappings in NORMAL mode
        toggler = {
          ---Line-comment toggle keymap
          line = 'gcc',
          ---Block-comment toggle keymap
          block = 'gbc',
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          ---Line-comment keymap
          line = 'gc',
          ---Block-comment keymap
          block = 'gb',
        },
      })
    end
  },

  { -- Automatically complete pairs
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup {}
    end
  },

  { -- Custom variable segment text objects
    'Julian/vim-textobj-variable-segment',
    dependencies = {
      'kana/vim-textobj-user'
    }
  },

  -- Custom operator framework - configuration defined in viml/functions.vim
  'kana/vim-operator-user',

}

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

  { -- "gc" to comment visual regions/lines
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

  { -- multiple editing, visual, and settings tweaks
    'echasnovski/mini.nvim',
    version = '*',
    config = function ()
      require('mini.bufremove').setup()
      require('mini.indentscope').setup()
      require('mini.cursorword').setup()
      require('mini.misc').setup()
      MiniMisc.setup_auto_root()
      -- require('mini.files').setup({
      --   vim.keymap.set('n', '<leader>N', require('mini.files').open(), { silent = true, desc = 'file column edit' })
      -- })
      require('mini.surround').setup({
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          add = 'ys', -- Add surrounding in Normal and Visual modes
          delete = 'ds', -- Delete surrounding
          find = '', -- Find surrounding (to the right)
          find_left = '', -- Find surrounding (to the left)
          highlight = '', -- Highlight surrounding
          replace = 'cs', -- Replace surrounding
          update_n_lines = '', -- Update `n_lines`

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },
      })
      require('mini.trailspace').setup()
      require('mini.basics').setup({
        -- Options. Set to `false` to disable.
        options = {
          -- Basic options ('termguicolors', 'number', 'ignorecase', and many more)
          basic = false,

          -- Extra UI features ('winblend', 'cmdheight=0', ...)
          extra_ui = false,

          -- Presets for window borders ('single', 'double', ...)
          win_borders = 'default',
        },

        -- Mappings. Set to `false` to disable.
        mappings = {
          -- Basic mappings (better 'jk', save with Ctrl+S, ...)
          basic = false,

          -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
          -- Supply empty string to not create these mappings.
          option_toggle_prefix = [[co]],

          -- Window navigation with <C-hjkl>, resize with <C-arrow>
          windows = false,

          -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
          move_with_alt = false,
        },
      })
      require('mini.align').setup({
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          start = 'go',
          start_with_preview = 'gO',
        },
      })
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
          todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
          note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
      -- require('mini.splitjoin').setup({
      --   -- Module mappings. Use `''` (empty string) to disable one.
      --   -- Created for both Normal and Visual modes.
      --   mappings = {
      --     toggle = 'gR',
      --     split = '',
      --     join = '',
      --   },
      -- })
      require('mini.ai').setup({
        -- Table with textobject id as fields, textobject specification as values.
        -- Also use this to disable builtin textobjects. See |MiniAi.config|.
        custom_textobjects = {
          -- Whole buffer
          a = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line('$'),
              col = math.max(vim.fn.getline('$'):len(), 1)
            }
            return { from = from, to = to }
          end
        }
      })
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

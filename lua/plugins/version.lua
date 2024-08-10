return {

  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    config = function ()
      require('gitsigns').setup{
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', 'gj', function()
            if vim.wo.diff then return 'gj' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', 'gk', function()
            if vim.wo.diff then return 'gk' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map('n', '<leader>G', function() gs.blame_line{full=true} end, { silent = true, desc = 'full blame' })
          map('n', '<leader>g', gs.blame_line,  { silent = true, desc = 'hover blame' })
          map('n', 'du', gs.diffthis,  { silent = true, desc = 'diff update' })
          map('n', 'dr', gs.refresh,  { silent = true, desc = 'diff refresh' })
          map('n', 'cu', '<cmd>Gitsigns setqflist 0<cr>',  { silent = true, desc = 'add changes to quickfix' })

          -- Text object
          map({'o', 'x'}, 'ij', ':<C-U>Gitsigns select_hunk<CR>',  { silent = true, desc = 'hunk' })
        end
      }
    end
  },

  { -- git interface within vim
    'tpope/vim-fugitive',
  }
}

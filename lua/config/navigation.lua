return {

  { -- Better navigation across marks, terminals, and tmux
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local harpoon_tmux = require("harpoon.tmux")
      local tmux_pane
      vim.api.nvim_create_user_command('TmuxPane', function(opts)
        tmux_pane = opts.fargs[1]
      end, { nargs = 1, desc = 'Set tmux pane' })
      vim.cmd('nnoremap mp :TmuxPane<space>')
      vim.api.nvim_create_user_command('TmuxSend', function(opts)
        harpoon_tmux.sendCommand(tmux_pane, opts.fargs[1] .. "\r")
      end, { nargs = 1, desc = 'Send command to tmux pane' })
      vim.cmd('nnoremap mss :TmuxSend<space>')
    end
  },

  { -- useful folder navigation/editing
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      float = {
        -- Padding around the floating window
        padding = 10,
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0,
        max_height = 0,
        border = nil,
        win_options = {
          winblend = 0,
        },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "auto",
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
    },
    -- Optional dependencies
    -- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    keys = {
      { "<leader>-", function() require('oil').open_float() end, desc = "File Navigation"}
    }
  },

  { -- jump to anything
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").jump({
            search = { mode = "search", max_length = 0 },
            highlight = { label = { after = { 0, 0 } } },
            pattern = "^"
          })
        end,
        desc = "Flash Line",
      },
      {
        "r",
        mode = "o",
        function()
          -- jump to a remote location to execute the operator
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
    },
    opts = {
      modes = {
        -- options used when flash is activated through
        -- a regular search with `/` or `?`
        search = {
          enabled = false, -- enable flash for search
          highlight = { backdrop = false },
          jump = { history = true, register = true, nohlsearch = true },
          search = {
            -- `forward` will be automatically set to the search direction
            -- `mode` is always set to `search`
            -- `incremental` is set to `true` when `incsearch` is enabled
          },
        },
        -- options used when flash is activated through
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        char = {
          enabled = false,
          -- by default all keymaps are enabled, but you can disable some of them,
          -- by removing them from the list.
          keys = { "f", "F", ";", "," },
          search = { wrap = false },
          highlight = { backdrop = true },
          jump = { register = false },
        },
      }
    }
  },

  { -- Seamless navigation between tmux and neovim
    'numToStr/Navigator.nvim',
    keys = {
      { '<C-h>', '<cmd>NavigatorLeft<cr>', { 'n', 't' }, silent = true, desc = 'left window/term'},
      { '<C-l>', '<cmd>NavigatorRight<cr>', { 'n', 't' }, silent = true, desc = 'right window/term'},
      { '<C-k>', '<cmd>NavigatorUp<cr>', { 'n', 't' }, silent = true, desc = 'up window/term'},
      { '<C-j>', '<cmd>NavigatorDown<cr>', { 'n', 't' }, silent = true, desc = 'down window/term'}
    },
    config = function()
      require('Navigator').setup({
        disable_on_zoom = true
      })
    end
  },

  { -- switch between relevant files quickly
    'jakemason/ouroboros',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function ()
      -- these are the defaults, customize as desired
      require('ouroboros').setup({
        extension_preferences_table = {
          -- Higher numbers are a heavier weight and thus preferred.
          -- In the following, .c would prefer to open .h before .hpp
          c = {h = 2, hpp = 1},
          h = {c = 2, cpp = 1},
          cpp = {hpp = 2, h = 1},
          hpp = {cpp = 1, c = 2},

          -- Ouroboros supports any combination of filetypes you like, simply
          -- add them as desired:
          -- myext = { myextsrc = 2, myextoldsrc = 1},
          -- tpp = {hpp = 2, h = 1},
          -- inl = {cpp = 3, hpp = 2, h = 1},
          -- cu = {cuh = 3, hpp = 2, h = 1},
          -- cuh = {cu = 1}
        },
        -- if this is true and the matching file is already open in a pane, we'll
        -- switch to that pane instead of opening it in the current buffer
        switch_to_open_pane_if_possible = false,
      })
    end,
    keys = {
      { "<leader>'", "<cmd>Ouroboros<CR>", desc = "Ouroboros Swap" },
    }
  }

}

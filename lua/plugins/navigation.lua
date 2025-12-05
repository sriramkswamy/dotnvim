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
    opts = {},
    -- Optional dependencies
    -- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    keys = {
      { "<leader>-", "<cmd>Oil<CR>", desc = "File Navigation"}
    }
  },

  { -- jump to anything
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
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
    config = function ()
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
          keys = { "f", "F", "t", "T", ";", "," },
          search = { wrap = false },
          highlight = { backdrop = true },
          jump = { register = false },
        },
      }
    end
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

}

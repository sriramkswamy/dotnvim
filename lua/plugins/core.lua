return {

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<C-j>'] = require('telescope.actions').move_selection_next,
              ['<C-k>'] = require('telescope.actions').move_selection_previous,
              ['<C-l>'] = require('telescope.actions').send_to_loclist,
              ['<C-h>'] = require('telescope.actions').send_to_qflist,
              -- ['<C-h>'] = "which-key"
            },
          },
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')

      -- See `:help telescope.builtin`
      vim.keymap.set('n', 'g/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Fuzzily search in current buffer' })

      -- Other keymaps
      vim.keymap.set('n', 'ga', require('telescope.builtin').grep_string, { desc = 'search current word' })
      vim.keymap.set('n', 'gt', require('telescope.builtin').tags, { desc = 'search tags' })
      vim.keymap.set('n', 'gl', require('telescope.builtin').loclist, { desc = 'search location list' })
      vim.keymap.set('n', 'gm', require('telescope.builtin').quickfix, { desc = 'search quickfix' })
      vim.keymap.set('n', 'cot', require('telescope.builtin').filetypes, { desc = 'change filetype' })
      vim.keymap.set('n', '<C-p>', require('telescope.builtin').jumplist, { desc = 'jump list' })
      vim.keymap.set('n', '<C-y>', require('telescope.builtin').registers, { desc = 'registers' })
      vim.keymap.set('n', '<leader>j', require('telescope.builtin').commands, { desc = 'vim commands' })
      vim.keymap.set('n', '<leader>k', require('telescope.builtin').buffers, { desc = 'open buffers' })
      vim.keymap.set('n', '<leader>\\', require('telescope.builtin').tags, { desc = 'search tags' })
      vim.keymap.set('n', '<leader>d', require('telescope.builtin').git_files, { desc = 'search git files' })
      vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = 'search files' })
      vim.keymap.set('n', '<leader>s', require('telescope.builtin').live_grep, { desc = 'search with grep' })
      vim.keymap.set('n', '<leader>i', require('telescope.builtin').diagnostics, { desc = 'diagnostics info' })
      vim.keymap.set('n', '<leader>x', require('telescope.builtin').help_tags, { desc = 'search help' })
      vim.keymap.set('n', '<leader>.', require('telescope.builtin').colorscheme, { desc = 'search colorscheme' })
      vim.keymap.set('n', '<leader>,', require('telescope.builtin').keymaps, { desc = 'search keymaps' })
      vim.keymap.set('n', '<leader>/', require('telescope.builtin').oldfiles, { desc = 'recent files' })
      vim.keymap.set('n', '<leader>;', require('telescope.builtin').command_history, { desc = 'command history' })

    end
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim'
    },
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- undo with telescope
    'debugloop/telescope-undo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('telescope').setup({
        extensions = {
          undo = {
            -- telescope-undo.nvim config, see below
          },
        },
      })
      require('telescope').load_extension('undo')
      vim.keymap.set('n', 'U', '<cmd>Telescope undo<cr>')
    end,
  },

  { -- navigate tabs with telescope
    'LukasPietzschmann/telescope-tabs',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>a', '<cmd>Telescope telescope-tabs list_tabs<cr>', 'n', silent = true, desc = 'switch tabs' }
    }
  },

  { -- session management
    'jedrzejboczar/possession.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function ()
      require('possession').setup {
        silent = false,
        load_silent = true,
        debug = false,
        logfile = false,
        prompt_no_cr = false,
        autosave = {
          current = true,  -- or fun(name): boolean
          tmp = true,  -- or fun(): boolean
          tmp_name = 'tmp',
          on_load = true,
          on_quit = true,
        },
        commands = {
          save = 'PossessionSave',
          load = 'PossessionLoad',
          close = 'PossessionClose',
          delete = 'PossessionDelete',
          show = 'PossessionShow',
          list = 'PossessionList',
          migrate = 'PossessionMigrate',
        },
        hooks = {
          before_save = function(name) return {} end,
          after_save = function(name, user_data, aborted) end,
          before_load = function(name, user_data) return user_data end,
          after_load = function(name, user_data) end,
        },
        plugins = {
          close_windows = {
            hooks = {'before_save', 'before_load'},
            preserve_layout = true,  -- or fun(win): boolean
            match = {
              floating = true,
              buftype = {},
              filetype = {},
              custom = false,  -- or fun(win): boolean
            },
          },
          delete_hidden_buffers = {
            hooks = {
              'before_load',
              vim.o.sessionoptions:match('buffer') and 'before_save',
            },
            force = false,  -- or fun(buf): boolean
          },
          nvim_tree = true,
          tabby = true,
          dap = true,
          delete_buffers = false,
        },
      }
      require('telescope').load_extension('possession')
      vim.keymap.set('n', '<leader><space>',
        function () require('telescope').extensions.possession.list() end,
        { silent = true, desc = 'load session'}
      )
    end
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Additional lua configuration
      { 'folke/neodev.nvim', opts = {} },
      -- Additional json configuration and vscode integration
      { 'folke/neoconf.nvim', opts = {} },
    },
  },

  {
    'glepnir/lspsaga.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', opts = {} }
    },
    event = 'BufRead',
    config = function()
      require('lspsaga').setup({
        symbol_in_winbar = {
          enable = false,
          separator = " ",
          ignore_patterns={},
          hide_keyword = true,
          show_file = true,
          folder_level = 2,
          respect_root = false,
          color_mode = true,
        },
        ui = {
          code_action = '!'
        }
      })
    end,
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      { 'L3MON4D3/LuaSnip', commit = "7552e6504ee95a9c8cfc6db53e389122ded46cd4", config = function() require("luasnip.loaders.from_snipmate").load() end },
      'saadparwaiz1/cmp_luasnip'
    },
    config = function ()
      -- nvim-cmp setup
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-g>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
          ['<C-v>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
          ['<C-l>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
      }
    end
  },

  { -- Folding based on code
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'indent', 'treesitter' }
        end
      })
    end,
  },

}

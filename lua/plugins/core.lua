return {

  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostics disable: missing-fields
    opts = {},
    ---@diagnostics enable: missing-fields
    keys = {
      { "t", function() FzfLua.lsp_document_symbols() end, desc = "Document Symbols"},
      { "U", function() FzfLua.undotree() end, desc = "Undo Tree"},
      { "ga", function() FzfLua.grep_cword() end, desc = "Grep current word"},
      { "gl", function() FzfLua.loclist() end, desc = "Location List"},
      { "gL", function() FzfLua.loclist_stack() end, desc = "Location Stack"},
      { "gm", function() FzfLua.quickfix() end, desc = "Quickfix List"},
      { "gM", function() FzfLua.quickfix_stack() end, desc = "Quickfix Stack"},
      { "gt", function() FzfLua.tags() end, desc = "Tags"},
      { "<C-p>", function() FzfLua.combine({pickers="jumps;changes"}) end, desc = "Jump/Change List"},
      { "<leader>a", function() FzfLua.nvim_options() end, desc = "Options"},
      { "<leader>c", function() FzfLua.lsp_workspace_symbols() end, desc = "Workspace Symbols"},
      { "<leader>d", function() FzfLua.git_files() end, desc = "Git Files"},
      { "<leader>f", function() FzfLua.combine({pickers="oldfiles;files"}) end, desc = "Files"},
      { "<leader>i", function() FzfLua.combine({pickers="diagnostics_document;diagnostics_workspace"}) end, desc = "Diagnostics"},
      { "<leader>j", function() FzfLua.commands() end, desc = "Commands"},
      { "<leader>k", function() FzfLua.buffers() end, desc = "Buffers"},
      { "<leader>r", function() FzfLua.lsp_references() end, desc = "References"},
      { "<leader>s", function() FzfLua.live_grep() end, desc = "Live Grep"},
      { "<leader>x", function() FzfLua.helptags() end, desc = "Help"},
      { "<leader>,", function() FzfLua.keymaps() end, desc = "Keymaps"},
      { "<leader>;", function() FzfLua.command_history() end, desc = "Command History"},
      { "<leader>/", function() FzfLua.search_history() end, desc = "Search History"},
      { "<leader>.", function() FzfLua.combine({pickers="registers;marks"}) end, desc = "Registers/Marks"},
    },
  },

  { -- multiple editing, visual, and settings tweaks
    'nvim-mini/mini.nvim',
    version = '*',
    config = function ()
      -- Centered on screen
      local win_config = function()
        local height = math.floor(0.618 * vim.o.lines)
        local width = math.floor(0.618 * vim.o.columns)
        return {
          anchor = 'NW', height = height, width = width,
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        }
      end,
      require('mini.bufremove').setup()
      require('mini.indentscope').setup()
      require('mini.cursorword').setup()
      require('mini.misc').setup()
      require('mini.files').setup()
      require('mini.clue').setup()
      -- require('mini.git').setup()
      require('mini.pairs').setup()
      require('mini.bufremove').setup()
      require('mini.misc').setup()
      require('mini.trailspace').setup()
      require('mini.sessions').setup({
        autoread = false,
        autowrite = true,
        -- directory = --<"session" subdir of user data directory from |stdpath()|>,
        file = 'Session.vim',
      })
      require('mini.bracketed').setup({
        buffer     = { suffix = 'b', options = {} },
        comment    = { suffix = 'c', options = {} },
        conflict   = { suffix = 'x', options = {} },
        diagnostic = { suffix = 'd', options = {} },
        file       = { suffix = 'f', options = {} },
        indent     = { suffix = 'i', options = {} },
        jump       = { suffix = 'j', options = {} },
        location   = { suffix = 'j', options = {} },
        oldfile    = { suffix = 'o', options = {} },
        quickfix   = { suffix = 'k', options = {} },
        treesitter = { suffix = 't', options = {} },
        undo       = { suffix = 'u', options = {} },
        window     = { suffix = 'w', options = {} },
        yank       = { suffix = 'y', options = {} },
      })
      -- require('mini.pick').setup({
      --   mappings = {
      --     toggle_info    = '<C-p>',
      --     move_down      = '<C-j>',
      --     move_up        = '<C-k>',
      --   },
      --   window = { config = win_config }
      -- })
      -- require('mini.extra').setup()
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
    end,
    keys = {
      { "<leader>n", function() MiniFiles.open() end, desc = "File Explorer"},
      { "Z", function() MiniMisc.zoom() end, desc = "Zoom"},
      { "<leader><CR>", function() MiniSessions.write() end, desc = "Write Session"},
      { "<leader><Space>", function() MiniSessions.read() end, desc = "Read Session"},
    },
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

  { -- Fast auto completion
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'super-tab' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = true } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
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

  { -- background runner
    'skywind3000/asyncrun.vim',
    keys = {
      { '<leader>u', '<cmd>AsyncStop<cr>', 'n', silent = true, desc = 'background run stop' }
    },
    config = function ()
      vim.cmd("let g:asyncrun_open = 10")
    end
  }

}

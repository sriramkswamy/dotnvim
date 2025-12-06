return {

  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostics disable: missing-fields
    opts = {},
    ---@diagnostics enable: missing-fields
    config = function ()
      require('fzf-lua').register_ui_select()
    end,
    keys = {
      { "+", function() vim.lsp.buf.add_workspace_folder() end, desc = "LSP Add Workspace Folder"},
      { "-", function() vim.lsp.buf.remove_workspace_folder() end, desc = "LSP Remove Workspace Folder"},
      { "#", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "LSP List Workspace Folders"},
      { "'", function() FzfLua.combine({pickers="registers;marks"}) end, desc = "Registers/Marks"},
      { "t", function() FzfLua.lsp_document_symbols() end, desc = "LSP Document Symbols"},
      { "K", function() vim.lsp.buf.hover() end, desc = "LSP Hover Info"},
      { "ga", function() FzfLua.grep_cword() end, desc = "Grep current word"},
      { "gd", function() FzfLua.lsp_definitions() end, desc = "LSP Definitions"},
      { "gD", function() FzfLua.lsp_declarations() end, desc = "LSP Declarations"},
      { "ge", function() FzfLua.tags() end, desc = "Get Tags"},
      { "gF", function() FzfLua.lsp_finder() end, desc = "LSP Finder"},
      { "gi", function() FzfLua.lsp_implementations() end, desc = "LSP Implementations"},
      { "gI", function() FzfLua.lsp_incoming_calls() end, desc = "LSP Incoming Calls"},
      { "gO", function() FzfLua.lsp_outgoing_calls() end, desc = "LSP Outgoing Calls"},
      { "gl", function() FzfLua.loclist() end, desc = "Location List"},
      { "gL", function() FzfLua.loclist_stack() end, desc = "Location Stack"},
      { "gm", function() FzfLua.quickfix() end, desc = "Quickfix List"},
      { "gM", function() FzfLua.quickfix_stack() end, desc = "Quickfix Stack"},
      { "gr", function() vim.lsp.buf.rename() end, desc = "LSP Rename"},
      { "gt", function() FzfLua.combine({pickers="lsp_type_sub;lsp_type_super"})() end, desc = "LSP Types"},
      { "gT", function() FzfLua.lsp_typedefs() end, desc = "LSP Typedefs"},
      { "<C-k>", mode = {"i"}, function() vim.lsp.buf.signature_help() end, desc = "LSP Signature Help"},
      { "<C-g>", function() FzfLua.combine({pickers="jumps;changes"}) end, desc = "Jump/Change List"},
      { "<leader>d", function() FzfLua.git_files() end, desc = "Git Files"},
      { "<leader>f", function() FzfLua.combine({pickers="oldfiles;files"}) end, desc = "Files"},
      { "<leader>h", function() FzfLua.lsp_code_actions() end, desc = "LSP Code Actions"},
      { "<leader>i", function() FzfLua.combine({pickers="diagnostics_document;diagnostics_workspace"}) end, desc = "LSP Diagnostics"},
      { "<leader>j", function() FzfLua.commands() end, desc = "Commands"},
      { "<leader>k", function() FzfLua.buffers() end, desc = "Buffers"},
      { "<leader>r", function() FzfLua.lsp_references() end, desc = "LSP References"},
      { "<leader>s", function() FzfLua.live_grep() end, desc = "Live Grep"},
      { "<leader>c", function() FzfLua.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols"},
      { "<leader>u", function() FzfLua.undotree() end, desc = "Undo History"},
      { "<leader>x", function() FzfLua.helptags() end, desc = "Help"},
      { "<leader>,", function() FzfLua.keymaps() end, desc = "Keymaps"},
      { "<leader>;", function() FzfLua.command_history() end, desc = "Command History"},
      { "<leader>/", function() FzfLua.search_history() end, desc = "Search History"},
      { "<leader>'", "<cmd>ClangdSwitchSourceHeader<CR>", desc = "CXX Switch Header/Source"},
      { "<leader>`", function() FzfLua.nvim_options() end, desc = "Options"},
    },
  },

  { -- multiple editing, visual, and settings tweaks
    'nvim-mini/mini.nvim',
    version = '*',
    config = function ()
      -- default setup is good
      require('mini.bufremove').setup()
      require('mini.indentscope').setup()
      require('mini.cursorword').setup()
      require('mini.misc').setup()
      require('mini.files').setup()
      require('mini.clue').setup()
      require('mini.pairs').setup()
      require('mini.bufremove').setup()
      require('mini.misc').setup()
      require('mini.statusline').setup()
      require('mini.icons').setup()
      require('mini.diff').setup()
      require('mini.trailspace').setup()

      -- custom setup
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
          start_with_preview = 'goo',
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
      require('mini.splitjoin').setup({
        -- Module mappings. Use `''` (empty string) to disable one.
        -- Created for both Normal and Visual modes.
        mappings = {
          toggle = 'gR',
          split = '',
          join = '',
        },
      })
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
      require('mini.operators').setup({
        evaluate = {
          prefix = 'g=',
          -- Function which does the evaluation
          func = nil,
        },
        -- Exchange text regions
        exchange = {
          prefix = 'cx',
          -- Whether to reindent new text to match previous indent
          reindent_linewise = true,
        },
        -- Multiply (duplicate) text
        multiply = {
          prefix = 'gx',
          -- Function which can modify text before multiplying
          func = nil,
        },
        -- Replace text with register
        replace = {
          prefix = 'cr',
          -- Whether to reindent new text to match previous indent
          reindent_linewise = true,
        },
        -- Sort text
        sort = {
          prefix = 'g-',
          -- Function which does the sort
          func = nil,
        }
      })
      -- call functions
      MiniMisc.setup_auto_root()
      -- Mappings not lazy loaded
      vim.keymap.set('n', '<leader>n', function() MiniFiles.open() end, {silent = true, desc = 'File Explorer'})
      vim.keymap.set('n', 'Z', function() MiniMisc.zoom() end, {silent = true, desc = 'Zoom Window'})
      vim.keymap.set({'n', 'v'}, 'gj', function() MiniDiff.goto_hunk("next") end, {silent = true, desc = 'Next Hunk'})
      vim.keymap.set({'n', 'v'}, 'gk', function() MiniDiff.goto_hunk("prev") end, {silent = true, desc = 'Previous Hunk'})
      vim.keymap.set({'o', 'x'}, 'ij', function() MiniDiff.textobject() end, {silent = true, desc = 'Hunk'})
      vim.keymap.set({'o', 'x'}, 'aj', function() MiniDiff.textobject() end, {silent = true, desc = 'Hunk'})
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = true },
      picker = { enabled = false },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      -- { "coo", function() Snacks.toggle() end, desc = "Toggle options" },
      { "coh", function() Snacks.toggle.inlay_hints() end, desc = "Toggle options" },
      { "<leader>t", function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>\\",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader><CR>", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    },
  },

  { -- Fast auto completion
    'saghen/blink.cmp',
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
    },
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
      keymap = {
        preset = 'super-tab',
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
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

  { -- background runner
    'skywind3000/asyncrun.vim',
    keys = {
      { '<leader>p', '<cmd>AsyncStop<cr>', 'n', silent = true, desc = 'background run stop' }
    },
    config = function ()
      vim.cmd("let g:asyncrun_open = 10")
    end
  },

  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    keys = {
      { "J", function() require('goto-preview').goto_preview_definition() end, desc = "LSP Peek Definitions"},
      { "<BS>", function() require('goto-preview').close_all_win() end, desc = "Close all previews"},
    }
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
    },
    keys = {
      { "H", "<cmd>AutoSession toggle<CR>", desc = "Toggle AutoSession" }
    }
  },

}

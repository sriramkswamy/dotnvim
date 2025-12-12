return {

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
      end

      -- default setup is good
      require('mini.bufremove').setup()
      require('mini.indentscope').setup()
      require('mini.cursorword').setup()
      require('mini.misc').setup()
      require('mini.files').setup()
      require('mini.pairs').setup()
      require('mini.bufremove').setup()
      require('mini.misc').setup()
      require('mini.statusline').setup()
      require('mini.icons').setup()
      require('mini.diff').setup()
      require('mini.trailspace').setup()
      require('mini.extra').setup()

      -- custom setup
      require('mini.clue').setup({
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<leader>' },
          { mode = 'x', keys = '<leader>' },
          { mode = 'n', keys = '<leader>a' },
          { mode = 'x', keys = '<leader>a' },
          { mode = 'n', keys = '<leader>p' },
          { mode = 'n', keys = '<leader>g' },
          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },
          -- `g` key
          -- { mode = 'n', keys = 'g' },
          -- { mode = 'x', keys = 'g' },
          { mode = 'n', keys = 'gs' },
          { mode = 'x', keys = 'gs' },
          { mode = 'n', keys = 'gw' },
          { mode = 'x', keys = 'gw' },
          -- Marks
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = '`' },
          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },
          -- Window commands
          { mode = 'n', keys = 'w' },
          { mode = 'n', keys = '<C-w>' },
          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },
        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          require('mini.clue').gen_clues.builtin_completion(),
          require('mini.clue').gen_clues.g(),
          require('mini.clue').gen_clues.marks(),
          require('mini.clue').gen_clues.registers(),
          require('mini.clue').gen_clues.windows(),
          require('mini.clue').gen_clues.z(),
        },
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
      require('mini.pick').setup({
        mappings = {
          toggle_info    = '<C-p>',
          move_down      = '<C-j>',
          move_up        = '<C-k>',
        },
        window = { config = win_config }
      })

      -- call functions
      MiniMisc.setup_auto_root()
      -- Mappings not lazy loaded
      vim.keymap.set('n', 'Z', function() MiniMisc.zoom() end, {silent = true, desc = 'Zoom Window'})
      vim.keymap.set('n', 'coo', function() MiniExtra.pickers.options() end, {silent = true, desc = 'Options'})
      vim.keymap.set('n', '<leader>n', function() MiniFiles.open() end, {silent = true, desc = 'File Explorer'})
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
      picker = { enabled = true },
      notify = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { "+", function() vim.lsp.buf.add_workspace_folder() end, desc = "LSP Add Workspace Folder"},
      { "-", function() vim.lsp.buf.remove_workspace_folder() end, desc = "LSP Remove Workspace Folder"},
      { "#", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "LSP List Workspace Folders"},
      { "'", function() Snacks.picker.registers() end, desc = "Registers"},
      { "t", function() Snacks.picker.lsp_symbols() end, desc = "LSP Document Symbols"},
      { "H", function() vim.diagnostic.open_float() end, desc = "LSP Hover Error"},
      { "K", function() vim.lsp.buf.hover() end, desc = "LSP Hover Info"},
      { "ga", function() Snacks.picker.grep_word() end, desc = "Grep current word"},
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "LSP Definitions"},
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "LSP Declarations"},
      { "ge", function() Snacks.picker.tags() end, desc = "Get Tags"},
      { "gF", function() Snacks.picker.format() end, desc = "LSP Finder"},
      { "gi", function() Snacks.picker.lsp_implementations() end, desc = "LSP Implementations"},
      { "gI", function() Snacks.picker.lsp_incoming_calls() end, desc = "LSP Incoming Calls"},
      { "gO", function() Snacks.picker.lsp_outgoing_calls() end, desc = "LSP Outgoing Calls"},
      { "gl", function() Snacks.picker.loclist() end, desc = "Location List"},
      -- { "gL", function() Snacks.picker.loclist_stack() end, desc = "Location Stack"},
      { "gm", function() Snacks.picker.quickfix() end, desc = "Quickfix List"},
      -- { "gM", function() Snacks.picker.quickfix_stack() end, desc = "Quickfix Stack"},
      { "gr", function() vim.lsp.buf.rename() end, desc = "LSP Rename"},
      { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP Type Definitions"},
      { "gT", function() Snacks.picker.lsp_config() end, desc = "LSP Config"},
      { "coh", function() Snacks.toggle.inlay_hints() end, desc = "Toggle Hints" },
      -- { "<C-k>", mode = {"i"}, function() vim.lsp.buf.signature_help() end, desc = "LSP Signature Help"},
      { "<leader>c", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols"},
      { "<leader>d", function() Snacks.picker.git_files() end, desc = "Git Files"},
      { "<leader>f", function() Snacks.picker.diagnostics_buffer() end, desc = "File Diagnostics"},
      -- { "<leader>h", function() Snacks.picker.actions() end, desc = "LSP Code Actions"},
      { "<leader>h", function() vim.lsp.buf.code_action() end, desc = "LSP Code Actions"},
      { "<leader>i", function() Snacks.picker.diagnostics() end, desc = "LSP Diagnostics"},
      { "<leader>j", function() Snacks.picker.commands() end, desc = "Commands"},
      -- { "<leader>k", function() Snacks.picker.buffers() end, desc = "Buffers"},
      { "<leader>k", function() Snacks.picker.smart() end, desc = "Smart Buffers"},
      { "<leader>r", function() Snacks.picker.lsp_references() end, desc = "LSP References"},
      { "<leader>s", function() Snacks.picker.grep() end, desc = "Live Grep"},
      { "<leader>t", function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<leader>u", function() Snacks.picker.undotree() end, desc = "Undo History"},
      { "<leader>x", function() Snacks.picker.help() end, desc = "Help"},
      { "<leader>y", function() Snacks.picker.jumps() end, desc = "Jump List"},
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches"},
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File"},
      { "<leader>gg", function() Snacks.picker.git_status() end, desc = "Git Status"},
      { "<leader>gh", function() Snacks.picker.git_diff() end, desc = "Git Hunks"},
      { "<leader>gl", function() Snacks.picker.git_log_line() end, desc = "Git Log Line"},
      { "<leader>go", function() Snacks.picker.git_log() end, desc = "Git Log"},
      { "<leader>gs", function() Snacks.picker.git_stash() end, desc = "Git Stash"},
      { "<leader>gw", function() Snacks.git.blame_line() end, desc = "Git Blame Line"},
      { "<leader>,", function() Snacks.picker.keymaps() end, desc = "Keymaps"},
      { "<leader>;", function() Snacks.picker.command_history() end, desc = "Command History"},
      { "<leader>/", function() Snacks.picker.search_history() end, desc = "Search History"},
      { "<leader>`", function() Snacks.picker.marks() end, desc = "Marks"},
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>\\",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader><CR>", function() Snacks.picker.pickers() end, desc = "Pickers"},
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

  { -- task runner
    'stevearc/overseer.nvim',
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {},
    keys = {
      { '<leader>po', '<cmd>OverseerToggle<cr>', 'n', silent = true, desc = 'Oversee Tasks' },
      { '<leader>pr', '<cmd>OverseerRun<cr>', 'n', silent = true, desc = 'Run Tasks' },
      { '<leader>ps', '<cmd>OverseerShell<cr>', 'n', silent = true, desc = 'Shell Task' },
    },
    config = function ()
      require("overseer").setup()
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
      { "<C-g>", "<cmd>AutoSession toggle<CR>", desc = "Toggle AutoSession" },
    },
  },

}

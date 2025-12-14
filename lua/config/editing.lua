return {

  { -- undo tree
    'mbbill/undotree',
    keys = {
      { 'U', '<cmd>UndotreeToggle<cr>', 'n', silent = true, desc = 'undo tree' }
    }
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- extend repeat
  'tpope/vim-repeat',

  { -- format code
    'stevearc/conform.nvim',
    ft = { "lua", "python", "cpp", "javascript", "typescript", "json", "html", "css", "markdown", "bash" },
    config = function ()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
          -- You can customize some of the format options for the filetype (:help conform.format)
          cpp = { "clang-format", lsp_format = "fallback" },
          -- Conform will run the first available formatter
          javascript = { "prettierd", "prettier", stop_after_first = true },
        },
      })
    end,
    keys = {
      { "gq", mode = {"n","x"}, function () require("conform").format({async = true}) end, desc = "Format" }
    }
  },

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

  { -- easy search and replace
    'MagicDuck/grug-far.nvim',
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require('grug-far').setup({
        -- options, see Configuration section below
        -- there are no required options atm
      });
    end,
    keys = {
      { "<leader><Space>", "<cmd>GrugFar<CR>", desc = "Search and Replace" }
    }
  },

  { -- multiple cursors
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()
        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            -- Select a different cursor as the main one.
            layerSet({"n", "x"}, "<C-b>", mc.prevCursor)
            layerSet({"n", "x"}, "<C-f>", mc.nextCursor)
            -- Delete the main cursor.
            layerSet({"n", "x"}, "<C-d>", mc.deleteCursor)
            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)
        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end,
    keys = {
      { "<C-q>", mode = { "n", "x" }, function () require("multicursor-nvim").toggleCursor() end, desc = "Toggle MC" },
      { "<C-n>", mode = { "n", "x" }, function () require("multicursor-nvim").matchAddCursor(1) end, desc = "Match MC Below" },
      { "<C-e>", mode = { "n", "x" }, function () require("multicursor-nvim").matchSkipCursor(1) end, desc = "Skip Match MC Below" },
      { "<C-p>", mode = { "n", "x" }, function () require("multicursor-nvim").matchAddCursor(-1) end, desc = "Match MC Above" },
      { "<C-y>", mode = { "n", "x" }, function () require("multicursor-nvim").matchSkipCursor(-1) end, desc = "Skip Match MC Above" },
    },
  },

  { -- Custom variable segment text objects
    'Julian/vim-textobj-variable-segment',
    dependencies = {
      'kana/vim-textobj-user'
    }
  },

  -- Custom operator framework - configuration defined in viml/functions.vim
  'kana/vim-operator-user',

  { -- AI Edit Suggestions
    "github/copilot.vim"
  },

  { -- AI Chat support
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
      window = {
        layout = 'float',
        width = 120, -- Fixed width in columns
        height = 40, -- Fixed height in rows
        border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
        title = '🤖 AI Assistant',
        zindex = 100, -- Ensure window stays on top
      },
      headers = {
        user = '👤 You',
        assistant = '🤖 Copilot',
        tool = '🔧 Tool',
      },
      separator = '━━',
    },
    keys = {
      { "<leader>aa", mode = { "n", "x" }, "<cmd>CopilotChatToggle<CR>", desc = "Toggle AI" },
      { "<leader>ae", mode = { "n", "x" }, "<cmd>CopilotChatExplain<CR>", desc = "AI Explain" },
      { "<leader>ar", mode = { "n", "x" }, "<cmd>CopilotChatReview<CR>", desc = "AI Review" },
      { "<leader>ad", mode = { "n", "x" }, "<cmd>CopilotChatDocs<CR>", desc = "AI Document" },
      { "<leader>ao", mode = { "n", "x" }, "<cmd>CopilotChatOptimize<CR>", desc = "AI Optimize" },
      { "<leader>af", mode = { "n", "x" }, "<cmd>CopilotChatFix<CR>", desc = "AI Fix" },
      { "<leader>at", mode = { "n", "x" }, "<cmd>CopilotChatTest<CR>", desc = "AI Test" },
      { "<leader>ac", mode = { "n", "x" }, "<cmd>CopilotChatCommit<CR>", desc = "AI Create Commit Message" },
      { "<leader>am", mode = { "n", "x" }, "<cmd>CopilotChatModels<CR>", desc = "AI Models" },
      { "<leader>ap", mode = { "n", "x" }, "<cmd>CopilotChatPrompts<CR>", desc = "AI Prompts" },
    },
  },

}

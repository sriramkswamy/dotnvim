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
      { "<leader>s", "<cmd>GrugFar<CR>", desc = "Search and Replace" }
    }
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
      { "<leader><CR>", mode = { "n", "x" }, "<cmd>CopilotChatToggle<CR>", desc = "Toggle Assistant" },
      { "<leader>aa", mode = { "n", "x" }, "<cmd>CopilotChatExplain<CR>", desc = "Ask Assistant to Explain" },
      { "<leader>ar", mode = { "n", "x" }, "<cmd>CopilotChatReview<CR>", desc = "Ask Assistant to Review" },
      { "<leader>ad", mode = { "n", "x" }, "<cmd>CopilotChatDocs<CR>", desc = "Ask Assistant to Document" },
      { "<leader>ao", mode = { "n", "x" }, "<cmd>CopilotChatOptimize<CR>", desc = "Ask Assistant to Optimize" },
      { "<leader>af", mode = { "n", "x" }, "<cmd>CopilotChatFix<CR>", desc = "Ask Assistant to Fix" },
      { "<leader>at", mode = { "n", "x" }, "<cmd>CopilotChatTest<CR>", desc = "Ask Assistant to Test" },
      { "<leader>ac", mode = { "n", "x" }, "<cmd>CopilotChatCommit<CR>", desc = "Ask Assistant to Create Commit Message" },
      { "<leader>am", mode = { "n", "x" }, "<cmd>CopilotChatModels<CR>", desc = "Assistant Models" },
      { "<leader>ap", mode = { "n", "x" }, "<cmd>CopilotChatPrompts<CR>", desc = "Assistant Prompts" },
    },
  },

}

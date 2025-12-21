return {

  { -- Java support
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    -- config = function ()
    --   vim.lsp.enable('jdtls')
    -- end,
  },

  { -- CSharp support
    'seblyng/roslyn.nvim',
    ft = 'cs',
  },

  { -- python venv management
    "neolooong/whichpy.nvim",
    dependencies = {
      -- "mfussenegger/nvim-dap-python", -- optional for debugging support
    },
    ft = 'python',
    cmd = { "WhichPy" },
    opts = {},
    keys = {
      { "<leader>xv", "<cmd>WhichPy select<CR>", desc = "Select Python Virtualenv" },
    },
  }

}

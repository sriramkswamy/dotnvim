return {
  -- jupyter notebook integration; wezterm is an image provider
  {
    'willothy/wezterm.nvim',
    config = true
  },

  {
    "benlubas/molten-nvim",
    -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "willothy/wezterm.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "wezterm.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
  },

  -- manage reproducible documents
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown" },
    config = function ()
      local quarto = require("quarto")
      quarto.setup({
        lspFeatures = {
          -- NOTE: put whatever languages you want here:
          languages = { "python", "bash" },
          chunks = "all",
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          -- NOTE: setup your own keymaps:
          hover = "K",
          definition = "gd",
          rename = "gr",
          references = "<leader>r",
          format = "gQ",
        },
        codeRunner = {
          enabled = true,
          default_method = "molten",
        },
      })

      local runner = require("quarto.runner")
      vim.keymap.set("n", "<localleader>c", runner.run_cell,  { desc = "run cell", silent = true })
      vim.keymap.set("n", "<localleader>a", runner.run_above, { desc = "run cell and above", silent = true })
      vim.keymap.set("n", "<localleader>A", runner.run_all,   { desc = "run all cells", silent = true })
      vim.keymap.set("n", "<localleader>l", runner.run_line,  { desc = "run line", silent = true })
      vim.keymap.set("v", "<localleader>r",  runner.run_range, { desc = "run visual range", silent = true })
      vim.keymap.set("n", "<localleader>R", function()
        runner.run_all(true)
      end, { desc = "run all cells of all languages", silent = true })

      require("nvim-treesitter.configs").setup({
        -- ... other ts config
        textobjects = {
          move = {
            enable = true,
            set_jumps = false, -- you can change this if you want.
            goto_next_start = {
              --- ... other keymaps
              ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
            },
            goto_previous_start = {
              --- ... other keymaps
              ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
            },
          },
          select = {
            enable = true,
            lookahead = true, -- you can change this if you want
            keymaps = {
              --- ... other keymaps
              ["ib"] = { query = "@code_cell.inner", desc = "in block" },
              ["ab"] = { query = "@code_cell.outer", desc = "around block" },
            },
          },
          swap = { -- Swap only works with code blocks that are under the same
            -- markdown header
            enable = true,
            swap_next = {
              --- ... other keymap
              ["cxl"] = "@code_cell.outer",
            },
            swap_previous = {
              --- ... other keymap
              ["cxh"] = "@code_cell.outer",
            },
          },
        }
      })

    end
  },

  {
    'GCBallesteros/jupytext.nvim',
    config = function ()
      require("jupytext").setup({
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      })
    end
  }
}

return {

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
      }
  },

  { -- using lazy.nvim
    'akinsho/bufferline.nvim',
    version = "*",
    -- dependencies = 'nvim-tree/nvim-web-devicons',
    config = function ()
      local bufferline = require('bufferline')
      bufferline.setup {
        options = {
          mode = "tabs", -- set to "tabs" to only show tabpages instead
          themable = true , -- allows highlight groups to be overriden i.e. sets highlights as default
          numbers = "none",
          indicator = {
            style =  'icon',
          },
          buffer_close_icon = '󰅖',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 18,
          max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
          truncate_names = true, -- whether or not tab names should be truncated
          tab_size = 18,
          diagnostics = false,
          diagnostics_update_in_insert = false,
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          show_duplicate_prefix = false,
          persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
          separator_style = "slant",
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
          },
        }
      }
    end
  },

  { -- Theme inspired by Atom
    'catppuccin/nvim',
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false, -- show the '~' characters after the end of buffers
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        auto_integrations = true,
      })
      -- setup must be called before loading
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  {
    'stevearc/quicker.nvim',
    ft = "qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
    keys = {
      { "<leader>m", function() require("quicker").toggle() end, desc = "Toggle Quickfix List" },
      { "<leader>l", function() require("quicker").toggle({loclist = true}) end, desc = "Toggle Location List" },
    },
    config = function ()
      require("quicker").setup({
        keys = {
          {
            ">",
            function()
              require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
            end,
            desc = "Expand quickfix context",
          },
          {
            "<",
            function()
              require("quicker").collapse()
            end,
            desc = "Collapse quickfix context",
          },
        },
      })
    end
  },

  { -- auto-folding based on treesitter/lsp
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {}, -- needed even when using default config
    -- recommended: disable vim's auto-folding
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
  },

  { -- pretty inline diagnostics
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function ()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({
        virtual_text = false, -- disable default virtual text
      })
    end
  }

}

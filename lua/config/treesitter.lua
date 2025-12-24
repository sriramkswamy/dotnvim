-- treesitter is not great on windows
local on_windows = vim.loop.os_uname().version:match 'Windows'

if on_windows then
  return {}
else
  return {

    { -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      ft = { 'c', 'cpp', 'python', 'lua', 'bash', 'html', 'json', 'yaml', 'markdown', 'markdown_inline', 'help' },
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
      },
      config = function()
        require'nvim-treesitter.install'.compilers = { "gcc", "clang" }
        -- See `:help nvim-treesitter`
        require('nvim-treesitter.configs').setup {
          -- Add languages to be installed here that you want installed for treesitter
          -- ensure_installed = { 'c', 'cpp', 'c_sharp', 'python', 'lua', 'bash', 'html', 'json', 'yaml', 'markdown', 'markdown_inline', 'help' },
          ensure_installed = { 'c', 'cpp', 'c_sharp', 'python', 'lua', 'bash', 'html', 'json', 'yaml', 'markdown', 'markdown_inline', 'vimdoc', 'regex' },
          -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
          auto_install = false,
          highlight = { enable = true },
          indent = { enable = true, disable = { 'python' } },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<c-space>',
              node_incremental = '<c-space>',
              scope_incremental = '<c-s>',
              node_decremental = '<M-space>',
            },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['ar'] = '@parameter.outer',
                ['ir'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
              },
              goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
              },
              goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
              },
              goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ['cxi'] = '@parameter.inner',
              },
              swap_previous = {
                ['cxo'] = '@parameter.inner',
              },
            },
          },
        }
        require'treesitter-context'.setup{
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          min_window_height = 50, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 2, -- Maximum number of lines to show for a single context
        }
        vim.keymap.set("n", "<C-e>", function()
          require("treesitter-context").go_to_context()
        end, { silent = true })
        pcall(require('nvim-treesitter.install').update { with_sync = true })
      end,
    },
  }

end

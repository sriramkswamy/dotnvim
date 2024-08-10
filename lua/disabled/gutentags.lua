local on_windows = vim.loop.os_uname().version:match 'Windows'

if on_windows then
  return {}
else
  return {

    { -- automatic management of tags
      'ludovicchabant/vim-gutentags',
      config = function ()
        vim.cmd("let g:gutentags_exclude_project_root = ['~/']")
        vim.cmd("let g:gutentags_add_ctrlp_root_markers = 0")
        vim.cmd("let g:gutentags_cache_dir = '~/.tags'")
        vim.cmd("let g:gutentags_ctags_executable = 'ctags'")
      end
    },

  }
end

--[[ LSP Language settings --]]

-- clangd (C/C++)
vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index', '--clang-tidy', '--inlay-hints=true' },
  filetypes = { "cpp", "c" },
  root_markers = {
    "compile_commands.json",
    ".git",
  },
  on_attach = lsp_on_attach,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "cxx" },
  desc = "lsp enable clangd",
  callback = function()
    vim.lsp.enable("clangd")
  end,
})
vim.keymap.set('n', '<leader>xlc', function () vim.lsp.enable('clangd') end, { silent = true, desc = 'Enable LSP clangd' })

-- pyright (Python)
vim.lsp.config('pyright', {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true
      }
    }
  },
  on_attach = lsp_on_attach,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  desc = "lsp enable pyright",
  callback = function()
    vim.lsp.enable("pyright")
  end,
})
vim.keymap.set('n', '<leader>xlp', function () vim.lsp.enable('pyright') end, { silent = true, desc = 'Enable LSP pyright' })

-- lua_ls (Lua)
vim.lsp.config('lua_ls', {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = lsp_on_attach
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua" },
  desc = "lsp enable lua_ls",
  callback = function()
    vim.lsp.enable("lua_ls")
  end,
})
vim.keymap.set('n', '<leader>xll', function () vim.lsp.enable('lua_ls') end, { silent = true, desc = 'Enable LSP lua_ls' })

-- viml (vimscript)
vim.lsp.config('vimls', {
  filetypes = { "vim" },
  root_markers = {
    "init.vim",
    "init.lua",
    ".vimrc",
    ".git",
  },
  on_attach = lsp_on_attach
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "vim" },
  desc = "lsp enable vimls",
  callback = function()
    vim.lsp.enable("vimls")
  end,
})
vim.keymap.set('n', '<leader>xlv', function () vim.lsp.enable('vimls') end, { silent = true, desc = 'Enable LSP vimls' })

-- marksman (Markdown)
vim.lsp.config('markdown', {
  cmd = { 'marksman', 'server' },
  filetypes = { "markdown" },
  on_attach = lsp_on_attach,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  desc = "lsp enable markdown",
  callback = function()
    vim.lsp.enable("markdown")
  end,
})
vim.keymap.set('n', '<leader>xlm', function () vim.lsp.enable('markdown') end, { silent = true, desc = 'Enable LSP markdown' })

-- roslyn (C#)
vim.lsp.config("roslyn", {
  -- cmd = {
  --   "/usr/local/share/dotnet/dotnet",
  --   "/Users/sriramkrishnaswamy/.local/share/nvim/mason/packages/roslyn/libexec/Microsoft.CodeAnalysis.LanguageServer.dll",
  --   "--logLevel", -- this property is required by the server
  --   "Information",
  --   "--extensionLogDirectory", -- this property is required by the server
  --   -- fs.joinpath(uv.os_tmpdir(), "roslyn_ls/logs"),
  --   "--stdio",
  -- },
  -- on_attach = lsp_on_attach,
  -- settings = {
  --   ["csharp|inlay_hints"] = {
  --     csharp_enable_inlay_hints_for_implicit_object_creation = true,
  --     csharp_enable_inlay_hints_for_implicit_variable_types = true,
  --   },
  --   ["csharp|code_lens"] = {
  --     dotnet_enable_references_code_lens = true,
  --   },
  -- },
})
vim.keymap.set('n', '<leader>xls', function () vim.lsp.enable('roslyn') end, { silent = true, desc = 'Enable LSP csharp' })

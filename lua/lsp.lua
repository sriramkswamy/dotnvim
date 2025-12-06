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

-- jdtls (Java Development Tools Language Server)
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.env.HOME .. '/jdtls-workspace/' .. project_name
vim.lsp.config('jdtls', {
  filetypes = { "java" },
  root_markers = {
    "mvnw",
    "gradlew",
    ".maven",
    ".git",
  },
  cmd = {
    -- CONFIGURE
    'java', -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    -- CONFIGURE
    -- ~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher
    '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
    -- '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher.cocoa.macosx.aarch64_1.2.1100.v20240613-2013.jar',
    -- '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
    -- '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version
    -- CONFIGURE
    -- ~/.local/share/nvim/mason/packages/jdtls/config_mac_arm
    '-configuration', '~/.local/share/nvim/mason/packages/jdtls/config_mac_arm',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.
    -- CONFIGURE
    -- See `data directory configuration` section in the README
    '-data', workspace_dir
  },
  on_attach = lsp_on_attach,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java" },
  desc = "lsp enable jdtls",
  callback = function()
    vim.lsp.enable("jdtls")
  end,
})

--[[ LSP settings --]]

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --- toggle inlay hints
  vim.g.inlay_hints_visible = true
  local function toggle_inlay_hints()
    if vim.g.inlay_hints_visible then
      vim.g.inlay_hints_visible = false
      vim.lsp.inlay_hint(bufnr, false)
    else
      if client.server_capabilities.inlayHintProvider then
        vim.g.inlay_hints_visible = true
        vim.lsp.inlay_hint(bufnr, true)
      else
        print("no inlay hints available")
      end
    end
  end

  --- toggle diagnostics
  vim.g.diagnostics_visible = true
  local function toggle_diagnostics()
    if vim.g.diagnostics_visible then
      vim.g.diagnostics_visible = false
      vim.diagnostic.enable(false)
    else
      vim.g.diagnostics_visible = true
      vim.diagnostic.enable()
    end
  end

  --- autocmd to show diagnostics on CursorHold
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    desc = "✨lsp show diagnostics on CursorHold",
    callback = function()
      local hover_opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
      }
      vim.diagnostic.open_float(nil, hover_opts)
    end,
  })

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- setup language servers

-- clangd
vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index', '--clang-tidy', '--inlay-hints=true' },
  filetypes = { "cpp", "c" },
  root_markers = {
    "compile_commands.json",
    ".git",
  },
  on_attach = on_attach,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "cxx" },
  desc = "lsp enable clangd",
  callback = function()
    vim.lsp.enable("clangd")
  end,
})

-- pyright
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
  on_attach = on_attach,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  desc = "lsp enable pyright",
  callback = function()
    vim.lsp.enable("pyright")
  end,
})

-- lua
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
  on_attach = on_attach
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua" },
  desc = "lsp enable lua_ls",
  callback = function()
    vim.lsp.enable("lua_ls")
  end,
})

-- viml
vim.lsp.config('vimls', {
  filetypes = { "vim" },
  root_markers = {
    "init.vim",
    "init.lua",
    ".vimrc",
    ".git",
  },
  on_attach = on_attach
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "vim" },
  desc = "lsp enable vimls",
  callback = function()
    vim.lsp.enable("vimls")
  end,
})

-- markdown
-- if not nvim_lsp_configs.markdown then
--   nvim_lsp_configs.markdown = {
--     default_config = {
--       cmd = { 'marksman', 'server' },
--       root_dir = nvim_lsp.util.root_pattern(".git", ".marksman.toml"),
--       single_file_support = true,
--       filetypes = { 'markdown' },
--     },
--   }
-- end
vim.lsp.config('markdown', {
  cmd = { 'marksman', 'server' },
  filetypes = { "markdown" },
  on_attach = on_attach,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  desc = "lsp enable markdown",
  callback = function()
    vim.lsp.enable("markdown")
  end,
})

-- jdtls LSP configuration
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.env.HOME .. '/jdtls-workspace/' .. project_name

-- if not nvim_lsp_configs.jdtls then
--   nvim_lsp_configs.jdtls = {
--     default_config = {
--       -- The command that starts the language server
--       -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--       cmd = {
--
--         -- CONFIGURE
--         'java', -- or '/path/to/java17_or_newer/bin/java'
--         -- depends on if `java` is in your $PATH env variable and if it points to the right version.
--
--         '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--         '-Dosgi.bundles.defaultStartLevel=4',
--         '-Declipse.product=org.eclipse.jdt.ls.core.product',
--         '-Dlog.protocol=true',
--         '-Dlog.level=ALL',
--         '-Xmx1g',
--         '--add-modules=ALL-SYSTEM',
--         '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--         '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
--
--         -- CONFIGURE
--         -- ~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher
--         '-jar', '/Users/sriramkrishnaswamy/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
--         -- '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher.cocoa.macosx.aarch64_1.2.1100.v20240613-2013.jar',
--         -- '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
--         -- '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
--         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--         -- Must point to the                                                     Change this to
--         -- eclipse.jdt.ls installation                                           the actual version
--
--
--         -- CONFIGURE
--         -- ~/.local/share/nvim/mason/packages/jdtls/config_mac_arm
--         '-configuration', '/Users/sriramkrishnaswamy/.local/share/nvim/mason/packages/jdtls/config_mac_arm',
--         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--         -- Must point to the                      Change to one of `linux`, `win` or `mac`
--         -- eclipse.jdt.ls installation            Depending on your system.
--
--
--         -- CONFIGURE
--         -- See `data directory configuration` section in the README
--         '-data', workspace_dir
--       },
--
--       -- CONFIGURE
--       -- This is the default if not provided, you can remove it. Or adjust as needed.
--       -- One dedicated LSP server & client will be started per unique root_dir
--       --
--       -- vim.fs.root requires Neovim 0.10.
--       -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
--       -- root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew", ".maven"}),
--       root_dir = nvim_lsp.util.root_pattern(".git", "mvnw", "gradlew", ".maven"),
--
--       single_file_support = true,
--       filetypes = { 'java' },
--     },
--   }
-- end
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
  on_attach = on_attach,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java" },
  desc = "lsp enable jdtls",
  callback = function()
    vim.lsp.enable("jdtls")
  end,
})

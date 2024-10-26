--[[ LSP settings --]]

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --- toggle inlay hints
  vim.g.inlay_hints_visible = false
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

  -- Mappings.
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, noremap = true, silent = true, desc = 'signature help' })
  vim.keymap.set('n', 'gd', "<cmd>Lspsaga goto_definition<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'goto definition' })
  vim.keymap.set('n', 'J', "<cmd>Lspsaga peek_definition<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'peek definition' })
  vim.keymap.set('n', '<BS>', "<cmd>Lspsaga hover_doc ++keep<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'pin doc' })
  vim.keymap.set('n', 'K', "<cmd>Lspsaga hover_doc<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'hover doc' })
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, noremap = true, silent = true, desc = 'doc' })
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { buffer = bufnr, noremap = true, silent = true, desc = 'implementation' })
  vim.keymap.set('n', '+', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, noremap = true, silent = true, desc = 'add workspace folder' })
  vim.keymap.set('n', '-', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, noremap = true, silent = true, desc = 'remove workspace folder' })
  vim.keymap.set('n', '#', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr, noremap = true, silent = true, desc = 'list workspace folders' })
  vim.keymap.set('n', '<leader>t', "<cmd>Lspsaga peek_type_definition<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'peek type definition' })
  vim.keymap.set('n', 'gT', "<cmd>Lspsaga goto_type_definition<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'goto type definition' })
  vim.keymap.set('n', 'gr', "<cmd>Lspsaga rename<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'rename in file' })
  vim.keymap.set('n', 'gR', "<cmd>Lspsaga rename ++project<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'rename in project' })
  vim.keymap.set('n', 'ge', "<cmd>Lspsaga show_line_diagnostics<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'show error' })
  vim.keymap.set('n', 'H', vim.diagnostic.setloclist, { buffer = bufnr, noremap = true, silent = true, desc = 'send errors to location list' })
  vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'previous diagnostic' })
  vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'next diagnostic' })
  vim.keymap.set("n", "[e", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, { buffer = bufnr, noremap = true, silent = true, desc = 'previous error' })
  vim.keymap.set("n", "]e", function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, { buffer = bufnr, noremap = true, silent = true, desc = 'next error' })
  vim.keymap.set('n', '<leader>\'', '<cmd>ClangdSwitchSourceHeader<CR>', { buffer = bufnr, noremap = true, silent = true, desc = 'switch header and source' })
  vim.keymap.set('n', '<leader>T', "<cmd>Lspsaga lsp_finder<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'find relevant items' })
  vim.keymap.set('n', '<leader>E', toggle_inlay_hints, { buffer = bufnr, noremap = true, silent = true, desc = 'toggle inlay hints' })
  vim.keymap.set('n', '<leader>I', toggle_diagnostics, { buffer = bufnr, noremap = true, silent = true, desc = 'toggle diagnostics' })
  vim.keymap.set('n', '<leader>r', require('telescope.builtin').lsp_references, { buffer = bufnr, noremap = true, silent = true, desc = 'references' })
  vim.keymap.set('n', 't', require('telescope.builtin').lsp_document_symbols, { buffer = bufnr, noremap = true, silent = true, desc = 'document symbols' })
  vim.keymap.set('n', 'T', "<cmd>Lspsaga outline<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'symbol outline' })
  vim.keymap.set('n', '<leader>c', require('telescope.builtin').lsp_dynamic_workspace_symbols, { buffer = bufnr, noremap = true, silent = true, desc = 'workspace symbols' })
  vim.keymap.set('n', '<leader>h', "<cmd>Lspsaga code_action<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'code action' })
  vim.keymap.set('n', '<C-n>', "<cmd>Lspsaga term_toggle<CR>", { buffer = bufnr, noremap = true, silent = true, desc = 'terminal' })
end

-- setup language servers
local nvim_lsp = require 'lspconfig'
local nvim_lsp_configs = require 'lspconfig.configs'
vim.g.inlay_hints_visible = true

-- clangd
nvim_lsp['clangd'].setup {
  cmd = { 'clangd', '--background-index', '--clang-tidy', '--inlay-hints=true' },
  on_attach = on_attach,
}

-- pyright
nvim_lsp['pyright'].setup {
  cmd = { "pyright-langserver", "--stdio" },
  on_attach = on_attach,
}

-- lua
nvim_lsp['lua_ls'].setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = on_attach
}

-- viml
nvim_lsp['vimls'].setup {
  on_attach = on_attach
}

-- markdown
if not nvim_lsp_configs.markdown then
  nvim_lsp_configs.markdown = {
    default_config = {
      cmd = { 'marksman', 'server' },
      root_dir = nvim_lsp.util.root_pattern(".git", ".marksman.toml"),
      single_file_support = true,
      filetypes = { 'markdown' },
    },
  }
end
nvim_lsp.markdown.setup{
  cmd = { 'marksman', 'server' },
  on_attach = on_attach,
}

-- jdtls LSP configuration
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.env.HOME .. '/jdtls-workspace/' .. project_name

if not nvim_lsp_configs.jdtls then
  nvim_lsp_configs.jdtls = {
    default_config = {
      -- The command that starts the language server
      -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
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
        '-jar', '/Users/sriramkrishnaswamy/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
        -- '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher.cocoa.macosx.aarch64_1.2.1100.v20240613-2013.jar',
        -- '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
        -- '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version


        -- CONFIGURE
        -- ~/.local/share/nvim/mason/packages/jdtls/config_mac_arm
        '-configuration', '/Users/sriramkrishnaswamy/.local/share/nvim/mason/packages/jdtls/config_mac_arm',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.


        -- CONFIGURE
        -- See `data directory configuration` section in the README
        '-data', workspace_dir
      },

      -- CONFIGURE
      -- This is the default if not provided, you can remove it. Or adjust as needed.
      -- One dedicated LSP server & client will be started per unique root_dir
      --
      -- vim.fs.root requires Neovim 0.10.
      -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
      -- root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew", ".maven"}),
      root_dir = nvim_lsp.util.root_pattern(".git", "mvnw", "gradlew", ".maven"),

      single_file_support = true,
      filetypes = { 'java' },
    },
  }
end
nvim_lsp.jdtls.setup{
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
    '-jar', '/Users/sriramkrishnaswamy/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
    -- '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher.cocoa.macosx.aarch64_1.2.1100.v20240613-2013.jar',
    -- '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
    -- '-jar', '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version


    -- CONFIGURE
    -- ~/.local/share/nvim/mason/packages/jdtls/config_mac_arm
    '-configuration', '/Users/sriramkrishnaswamy/.local/share/nvim/mason/packages/jdtls/config_mac_arm',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.


    -- CONFIGURE
    -- See `data directory configuration` section in the README
    '-data', workspace_dir
  },
  on_attach = on_attach,
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-g>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-v>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    ['<C-l>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

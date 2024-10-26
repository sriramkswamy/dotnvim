return {

  -- Automatically install LSPs to stdpath for neovim
  { 'williamboman/mason.nvim', opts = {} },
  { 'williamboman/mason-lspconfig.nvim',
    config = function ()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "pyright",
          "clangd",
          "marksman",
          "jdtls",
          "jsonls",
          "bashls",
          "html",
          "cssls"
        },
      }
    end
  },

}

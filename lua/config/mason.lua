return {

  -- Automatically install LSPs to stdpath for neovim
  { 'williamboman/mason.nvim', opts = {} },
  { 'williamboman/mason-lspconfig.nvim',
    config = function ()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "stylua",
          "pyright",
          -- "isort",
          -- "black",
          "clangd",
          -- "clang-format",
          "marksman",
          "jdtls",
          "jsonls",
          -- "prettier",
          -- "prettierd",
          "bashls",
          "html",
          "eslint",
          "ts_ls",
          "cssls",
          "roslyn",
          "copilot"
        },
      }
    end
  },

}

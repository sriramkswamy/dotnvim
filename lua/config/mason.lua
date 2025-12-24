return {

  -- Automatically install LSPs to stdpath for neovim
  { 'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = {
        "lua-language-server", "stylua",
        "pyright", "isort", "black",
        "clangd", "clang-format",
        "marksman",
        "jdtls",
        "html-lsp", "css-lsp",
        "eslint-lsp", "typescript-language-server",
        "json-lsp",
        "prettier", "prettierd",
        "roslyn", "csharpier", "rzls",
        "bashls",
        "copilot"
      },
    }
  },
}

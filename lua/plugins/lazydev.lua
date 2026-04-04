-- CORRETO - use aspas simples, não duplas dentro da lista
vim.pack.add({
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/neovim/nvim-lspconfig',
})

-- Configurar lazydev
require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
  integrations = {
    lspconfig = true,
    cmp = true,
  },
})

-- Configurar LSP
require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        checkThirdParty = false,
      },
      completion = {
        callSnippet = "Replace"
      },
    },
  },
})

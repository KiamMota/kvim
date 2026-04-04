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

-- Configurar LSP (nova API do Neovim 0.11+)
vim.lsp.config.lua_ls = {
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
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
}

-- Ativar o LSP para Lua
vim.lsp.enable('lua_ls')

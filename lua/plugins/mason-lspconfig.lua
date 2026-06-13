vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason-lspconfig.nvim',
})
require('mason').setup()
require('mason-lspconfig').setup({
 automatic_installation = true,
 ensure_installed = { "rust_analyzer", "clangd" },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })
    end,
  },
})

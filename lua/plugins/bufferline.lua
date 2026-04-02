vim.pack.add({
  {
    src = 'https://github.com/nvim-tree/nvim-web-devicons',
    opt = false  -- carrega automaticamente
  }
})

-- Depois instala o bufferline
vim.pack.add({
  {
    src = 'https://github.com/akinsho/bufferline.nvim',
    opt = false,  -- carrega automaticamente
    config = function()
      -- garante que a dependência está carregada
      vim.cmd('packadd nvim-web-devicons')

      require("bufferline").setup({
        options = {
          mode = "buffers",
          always_show_bufferline = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          diagnostics = "nvim_lsp",
          separator_style = "thick",
        },
      })
    end
  }
})

require('bufferline').setup()

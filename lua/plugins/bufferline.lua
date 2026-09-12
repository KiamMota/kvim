vim.opt.termguicolors = true

vim.pack.add({
  {
    src = 'https://github.com/nvim-tree/nvim-web-devicons',
    opt = false
  }
})

vim.pack.add({
  {
    src = 'https://github.com/akinsho/bufferline.nvim',
    opt = false
  }
})

require("bufferline").setup({
  options = {
    show_buffer_icons = false,

    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "none",
    always_show_bufferline = true,
  },
})

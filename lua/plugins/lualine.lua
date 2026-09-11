vim.opt.termguicolors = true

vim.cmd('packadd! lualine.nvim')
vim.cmd('packadd! nvim-web-devicons')

require('lualine').setup({
  options = {
    theme = 'auto',
    globalstatus = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '', right = '' }, right_padding = 2 }
    },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {
      { 'filename', path = 1, symbols = { modified = ' ', readonly = ' ', unnamed = '[No Name]' } }
    },
    lualine_x = {
      { 'encoding', cond = function() return vim.opt.fileencoding:get() ~= 'utf-8' end },
      'fileformat',
      'filetype'
    },
    lualine_y = { 'progress' },
    lualine_z = {
      { 'location', separator = { left = '', right = '' }, left_padding = 2 }
    }
  }
})

-- lua/plugins/lualine.lua

vim.pack.add({
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
})

require('lualine').setup({
  options = {
    icons_enabled        = true,
    theme                = 'auto',
    component_separators = { left = '', right = '' },
    section_separators   = { left = '', right = '' },
    disabled_filetypes   = { statusline = {}, winbar = {} },
    always_divide_middle = true,
    always_show_tabline  = true,
    globalstatus         = false,
    refresh = {
      statusline   = 1000,
      tabline      = 1000,
      winbar       = 1000,
      refresh_time = 16,
      events = {
        'WinEnter', 'BufEnter', 'BufWritePost',
        'SessionLoadPost', 'FileChangedShellPost',
        'VimResized', 'Filetype',
        'CursorMoved', 'CursorMovedI', 'ModeChanged',
      },
    },
  },
sections = {
  lualine_a = { 'mode', 'location' },
  lualine_b = { 'filename', 'filetype' },
  lualine_c = { 'branch', 'diff', 'diagnostics' },
  lualine_y = { 'encoding', function() return vim.fn.getcwd() end, 'progress' },
  lualine_z = { '' },
},
  inactive_sections = {
    lualine_c = { '' },
    lualine_x = { '' },
  },
  tabline         = {},
  winbar          = {},
  inactive_winbar = {},
  extensions      = {},
})

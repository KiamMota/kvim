-- lua/plugins/lualine.lua

vim.pack.add({
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
})

require('lualine').setup({
  options           = {
    icons_enabled        = true,
    theme                = 'auto',
    component_separators = { left = '', right = '' },
    section_separators   = { left = '', right = '' },
    disabled_filetypes   = { statusline = {}, winbar = {} },
    always_divide_middle = true,
    always_show_tabline  = true,
    globalstatus         = false,
    refresh              = {
      statusline   = 1000,
      tabline      = 1000,
      winbar       = 1000,
      refresh_time = 16,
      events       = {
        'WinEnter', 'BufEnter', 'BufWritePost',
        'SessionLoadPost', 'FileChangedShellPost',
        'VimResized', 'Filetype',
        'CursorMoved', 'CursorMovedI', 'ModeChanged',
      },
    },
  },
  sections          = {
    lualine_a = { 'mode', 'location' },
    lualine_b = { 'filename', 'filetype' },
    lualine_c = { 'branch', 'diff', 'diagnostics' },
    lualine_y = { 
      function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname == '' then
          return ''                          -- sem arquivo aberto
        end
        return vim.fn.fnamemodify(bufname, ':h') -- diretório do buffer
      end,
      'progress',
      'encoding',
    },
    lualine_x = { },
    lualine_z = { },

  },
  inactive_sections = {
  },
  tabline           = {},
  winbar            = {},
  inactive_winbar   = {},
  extensions        = {},
  })

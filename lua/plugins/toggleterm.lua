-- lua/plugins/toggleterm.lua

vim.pack.add({
  { src = 'https://github.com/akinsho/toggleterm.nvim' },
})
require('toggleterm').setup({
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,

  -- open_mapping = removido
  hide_numbers      = true,
  start_in_insert   = true,
  insert_mappings   = false,
  terminal_mappings = true,
  persist_size      = true,
  persist_mode      = true,
  direction         = 'float',
  close_on_exit     = true,
})

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

vim.keymap.set('n', '<leader>/', '<cmd>ToggleTerm<cr>', { desc = 'Toggle terminal' })

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
  cmd       = 'lazygit',
  hidden    = true,
  direction = 'float',
})

vim.keymap.set('n', '<leader>gg', function()
  lazygit:toggle()
end, { desc = 'LazyGit' })

vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Terminal horizontal' })
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>',   { desc = 'Terminal vertical' })
vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>',      { desc = 'Terminal float' })
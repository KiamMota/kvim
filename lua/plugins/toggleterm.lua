vim.pack.add({
  { src = 'https://github.com/akinsho/toggleterm.nvim' },
})

require('toggleterm').setup({
  size = 15, -- Uma altura fixa de 15 linhas é comum para o estilo VS Code
  direction = 'horizontal', -- Muda de 'float' para 'horizontal'
  
  -- Garante que o terminal sempre abra na base da tela
  on_open = function(term)
    vim.cmd("wincmd J") 
  end,

  hide_numbers = true,
  start_in_insert = true,
  terminal_mappings = true,
  persist_size = true,
  close_on_exit = true,
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

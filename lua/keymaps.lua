vim.keymap.set('n', '<C-s>', '<cmd>write<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', '<Esc><cmd>write<CR>a', { noremap = true, silent = true })
vim.keymap.set('v', '<C-s>', '<Esc><cmd>write<CR>gv', { noremap = true, silent = true })


vim.keymap.set('n', '<leader>rl', function()
  local file = vim.fn.expand('%:t:r')        -- nome do arquivo atual sem extensão
  local mod  = vim.fn.expand('%:.:r')        -- caminho relativo sem extensão
               :gsub('/', '.')               -- converte / para .
               :gsub('lua%.', '')            -- remove prefixo lua.
  package.loaded[mod] = nil
  require(mod)
  vim.notify('Reloaded: ' .. mod)
end, { desc = 'Reload current lua file' })
vim.keymap.set('n', '<C-a>', function()
  vim.cmd('normal! ggVG')
end)

vim.keymap.set('n', '<C-Left>', ':bprevious<CR>', { desc = 'prev buf' })
vim.keymap.set('n', '<C-Right>', ':bnext<CR>', { desc = 'next buf' })

vim.keymap.set('n', '<S-Tab>', ':bnext<CR>')

vim.cmd([[cnoreabbrev Thisd lcd %:p:h]])
vim.keymap.set('n', '<C-w>', ':bdelete<CR>', { silent = true })
vim.keymap.set("n", "<A-Down>", ":m .+2<CR>==", { silent = true })
vim.keymap.set("n", "<A-Up>", ":m .-1<CR>==", { silent = true })

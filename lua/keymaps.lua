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
vim.keymap.set('n', '<C-l>', ":bnext<CR>")
vim.keymap.set('n', '<C-h>', ":bnext<CR>")
vim.keymap.set('n', '<S-Tab>', ':bnext<CR>')

vim.cmd([[cnoreabbrev Thisd lcd %:p:h]])
vim.keymap.set('n', '<C-w>', ':bdelete<CR>', { silent = true })
vim.keymap.set("n", "<A-Down>", function()
  vim.cmd("m .+1")      -- move a linha
  vim.cmd("normal! ==") -- autoindent
end, { silent = true })

vim.keymap.set("n", "<A-Up>", function()
  vim.cmd("m .-2")      -- move a linha
  vim.cmd("normal! ==")
end, { silent = true })

-- Move seleção no visual mode
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set('n', '<C-s>', '<cmd>write<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', '<Esc><cmd>write<CR>a', { noremap = true, silent = true })
vim.keymap.set('v', '<C-s>', '<Esc><cmd>write<CR>gv', { noremap = true, silent = true })

vim.keymap.set('n', '<Up>', '<Nop>')
vim.keymap.set('n', '<Down>', '<Nop>')
vim.keymap.set('n', '<Left>', '<Nop>')
vim.keymap.set('n', '<Right>', '<Nop>')
vim.keymap.set('i', '<Up>', '<Nop>')
vim.keymap.set('i', '<Down>', '<Nop>')
vim.keymap.set('i', '<Left>', '<Nop>')
vim.keymap.set('i', '<Right>', '<Nop>')

vim.keymap.set('n', '<C-Left>', ':bprevious<CR>', { desc = 'prev buf' })
vim.keymap.set('n', '<C-Right>', ':bnext<CR>', { desc = 'next buf' })
vim.keymap.set('n', '<leader>cl', ':close<CR>', {desc = 'close buffer'})

vim.keymap.set('n', '<S-Tab>', ':bnext<CR>')

vim.cmd([[cnoreabbrev Thisd lcd %:p:h]])
vim.keymap.set('n', '<C-b>', ':bdelete<CR>', { silent = true })
vim.keymap.set("n", "<A-j>", function()
  vim.cmd("m .+1")
  vim.cmd("normal! ==")
end, { silent = true })

vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })

vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set('v', '<Tab>', '>gv', { silent = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { silent = true })

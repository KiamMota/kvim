vim.o.cmdheight = 1
vim.g.ui2 = true
vim.opt.shortmess:append("C") -- suprime mensagens de completion
vim.opt.shortmess:append("I") -- suprime intro
vim.opt.shortmess:append("W") -- suprime mensagens de escrita
vim.g.mapleader = ' '  
vim.o.number = true
vim.o.relativenumber = true
vim.o.syntax = "on"
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.title = true 
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.numberwidth = 5
vim.opt.signcolumn = "yes"
vim.opt.guicursor = "a:block"

-- REMOVE BORDAS ARREDONDADAS
if vim.g.neovide then
  -- Desativa bordas arredondadas no Neovide
  vim.g.neovide_floating_blur_amount_x = 0
  vim.g.neovide_floating_blur_amount_y = 0
  vim.g.neovide_floating_shadow = false
  
  -- Keymaps de zoom
  vim.keymap.set({ "n", "v" }, "<C-=>", function()
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1) + 0.1
  end)
  vim.keymap.set({ "n", "v" }, "<C-->", function()
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1) - 0.1
  end)
  vim.keymap.set({ "n", "v" }, "<C-0>", function()
    vim.g.neovide_scale_factor = 1
  end)
end


vim.g.mapleader      = ' '
vim.filetype.add({
  extension = {
    h = "c",
  }
})
vim.opt.termguicolors = true
vim.g.maplocalleader = '\\'
vim.api.nvim_create_user_command("Edit", function()
  local config_path = vim.fn.stdpath("config")
  vim.cmd("cd " .. config_path)
end, {})
require("autopairs").setup()
require("plugins.load") -- PRIMEIRO: instala e carrega tudo
require("editor")       -- configurações gerais do editor
require("keymaps")      -- keymaps que podem depender de plugins
require("lsp")          -- lsp que depende de mason/lspconfig
require("abbrev")
require("load-nvim").setup()

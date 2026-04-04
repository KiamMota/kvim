vim.g.mapleader      = ' '


vim.g.maplocalleader = '\\'
vim.api.nvim_create_user_command("Edit", function()
  local config_path = vim.fn.stdpath("config")
  vim.cmd("cd " .. config_path)
end, {})

require("plugins.load") -- PRIMEIRO: instala e carrega tudo
require("editor")       -- configurações gerais do editor
require("keymaps")      -- keymaps que podem depender de plugins
require("lsp")          -- lsp que depende de mason/lspconfig

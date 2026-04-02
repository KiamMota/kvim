vim.api.nvim_create_user_command("Edit", function()
  local config_path = vim.fn.stdpath("config")
  vim.cmd("cd " .. config_path)
end, {})

require("keymaps")
require("editor")
require("lsp")
require("plugins.load")


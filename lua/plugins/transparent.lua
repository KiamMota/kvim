
vim.pack.add({"https://github.com/xiyaowong/transparent.nvim"})
-- The plugin loads automatically because it is in the 'start/' directory
require("transparent").setup({
  extra_groups = {
    "NormalFloat",
    "NemoTreeNormal",
    "SignColumn",
  },
})

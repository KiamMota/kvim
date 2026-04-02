vim.pack.add({"https://github.com/nvim-tree/nvim-tree.lua"});

require("nvim-tree").setup({
  view = {
    float = {
      enable = true,
      open_win_config = {
        border = "rounded",
        width = 40,
      },
    },
  },
})

vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { noremap = true, silent = true })

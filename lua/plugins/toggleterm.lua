vim.pack.add({
  "https://github.com/akinsho/toggleterm.nvim"
})

require("toggleterm").setup({
  size = 3,               -- altura do terminal flutuante
  start_in_insert = true,
  direction = "float",
  close_on_exit = true,
  float_opts = {
    border = "rounded",
    winblend = 0,
  },
  on_open = function(term)
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "t",
      "<Esc>",
      "<C-\\><C-n>:close<CR>",
      { noremap = true, silent = true }
    )
  end,
})

vim.keymap.set("n", "<leader>t", function()
  require("toggleterm.terminal").Terminal:new({
    direction = "float",
    size = 7
  }):toggle()
end, { noremap = true, silent = true })

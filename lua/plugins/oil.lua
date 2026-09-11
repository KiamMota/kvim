vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
  keymaps = {
    ["-"] = function()
      require("oil").open(vim.fn.getcwd())
    end,

    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
  },
})

vim.keymap.set("n", "-", function()
  require("oil").open(vim.fn.getcwd())
end, { desc = "Abrir Oil no PWD" })

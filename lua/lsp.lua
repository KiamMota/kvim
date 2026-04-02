vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },

  virtual_lines = false, -- ❌ desativa linhas embaixo

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN]  = "W",
      [vim.diagnostic.severity.INFO]  = "I",
      [vim.diagnostic.severity.HINT]  = "H",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,

  float = {
    border = "rounded",
    source = true,
  },
})
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end)

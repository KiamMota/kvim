vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR },
    spacing = 4,
    prefix = "●",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always", -- Mostra qual servidor (ex: Roslyn/Omnisharp) gerou o erro
    header = "",
    prefix = "",
  },
})

local format_fn = function()
  vim.lsp.buf.format({ async = true })
end

vim.keymap.set({ "n", "v" }, "<leader>lf", format_fn, { desc = "LSP: Format File/Range" })

vim.keymap.set("n", "<leader>lr", function()
  vim.lsp.buf.rename()
end, { desc = "LSP: Rename Symbol" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
vim.keymap.set("n", "gr", function()
  vim.lsp.buf.references(nil, {
    on_list = function(options)
      vim.fn.setqflist({}, " ", options)
      vim.cmd("copen")
    end,
  })
end, { desc = "Go to References (Quickfix)" })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.cs",
  callback = function()
    vim.lsp.buf.format({ async = false }) -- Aqui deve ser síncrono para salvar após formatar
  end,
})

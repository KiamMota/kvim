--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- 1. Configuração de Diagnósticos (Melhorada)
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
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

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- 2. Atalhos de LSP (Format & Rename)
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
local dlog = require("dotnet.internal.dotnet_log")

-- Formatação (Normal e Visual Mode)
local format_fn = function()
  vim.lsp.buf.format({ async = true })
  dlog.dotnet_log("Código formatado")
end

vim.keymap.set({ "n", "v" }, "<leader>lf", format_fn, { desc = "LSP: Format File/Range" })

-- Renomear Símbolo (Refactor)
vim.keymap.set("n", "<leader>lr", function()
  -- Se você tiver o plugin 'dressing.nvim', isso vira uma janela flutuante linda
  vim.lsp.buf.rename()
end, { desc = "LSP: Rename Symbol" })

-- Extra: Ver Definição/Referências em Floating Window
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- 3. Auto-Format ao Salvar (Opcional, mas muito útil para C#)
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.cs",
  callback = function()
    vim.lsp.buf.format({ async = false }) -- Aqui deve ser síncrono para salvar após formatar
  end,
})

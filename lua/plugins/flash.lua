vim.pack.add({"https://github.com/folke/flash.nvim"})

require("flash").setup({
  mappings = {
    next = "n",  -- Agora 'n' pula para o próximo 'true'
    prev = "N",  -- Agora 'N' volta para o anterior
  },
  -- Opcional: destaca o destino conforme você pula
  jump = {
    n_next = true,
  },
})

-- Seu mapeamento para disparar o Flash continua o mesmo
vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { noremap = true, desc = "Flash Jump" })

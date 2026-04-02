vim.pack.add({
  { 
    src = 'https://github.com/windwp/nvim-autopairs', 
    opt = true,  -- não carrega automaticamente
    config = function()
      require('nvim-autopairs').setup({})
    end
  }
})

-- Carrega o plugin quando entrar no modo de inserção
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.cmd("packadd nvim-autopairs")  -- carrega o plugin
    if vim.fn.exists(":NvimAutopairs") then
      -- chama a função de configuração
      require('nvim-autopairs').setup({})
    end
  end
})
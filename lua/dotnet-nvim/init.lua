local M = {}

-- Criamos uma variável no escopo do módulo para garantir que o 
-- Garbage Collector não limpe o watcher enquanto o Neovim estiver aberto.
M._watcher = nil 

function M.setup(opts)
  -- 1. Carrega os módulos necessários
  require("dotnet.core.project_actions")
  require("dotnet.commands")

  -- 2. Evita iniciar múltiplos watchers se o setup for chamado duas vezes
  if M._watcher then
    M._watcher:stop()
  end

  -- 3. Inicia o watcher
  -- IMPORTANTE: Usamos o FSWatcher refatorado que te passei antes
  local FSWatcher = require("dotnet.core.fswatcher") 
  
  -- Use :p para garantir caminho absoluto
  local root_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
  
  M._watcher = FSWatcher.new(root_dir)
  M._watcher:start()

  -- Log de confirmação (se o seu dlog estiver funcionando)
  local dlog = require("dotnet.internal.dotnet_log")
  dlog.dotnet_log("Dotnet plugin initialized at: " .. root_dir)
end

function M.stop_watcher()
  if M._watcher then
    M._watcher:stop()
    M._watcher = nil
  end
end

return M

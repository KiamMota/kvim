-- ~/.config/nvim/lua/dotnet/internal/fswatcher.lua
local dlog = require("dotnet.internal.dotnet_log")
local ContextActions = require("dotnet.core.context_actions")
local uv = vim.uv or vim.loop
local FSWatcher = {}
FSWatcher.__index = FSWatcher

--- Busca recursiva simples ou no diretório atual
local function find_project_or_solution(dir)
  -- Buscamos por .sln em qualquer lugar abaixo do dir (limite de 2 níveis para performance)
  local sln = vim.fn.globpath(dir, "**/*.sln", false, true)
  if #sln > 0 then
    -- Retorna o primeiro .sln encontrado
    return nil, sln[1]
  end

  -- Se não houver .sln, buscamos por .csproj
  local csproj = vim.fn.globpath(dir, "**/*.csproj", false, true)
  if #csproj > 0 then
    -- Retorna o primeiro .csproj encontrado
    return csproj[1], nil
  end

  return nil, nil
end

function FSWatcher.new(path)
  local self = setmetatable({}, FSWatcher)
  self.path = uv.fs_realpath(path) or path
  self.watcher = nil
  return self
end

function FSWatcher:update_context_from_dir()
  local csproj, sln = find_project_or_solution(self.path)
  
  if sln then
    -- :p garante o caminho completo /home/user/.../projeto.sln
    local full_sln = vim.fn.fnamemodify(sln, ":p")
    ContextActions.set_current_solution(full_sln)
  elseif csproj then
    -- :p garante o caminho completo /home/user/.../projeto.csproj
    local full_csproj = vim.fn.fnamemodify(csproj, ":p")
    
    ContextActions.set_current_solution(nil)
    -- Passamos o arquivo completo dentro da tabela
    ContextActions.set_current_project({ full_csproj })
  else
    ContextActions.set_current_solution(nil)
    ContextActions.set_current_project({})
  end
end

function FSWatcher:start()
  if self.watcher then return end -- Evita duplicar watchers

  dlog.dotnet_log("Iniciando FSWatcher em: " .. self.path)
  
  self:update_context_from_dir()
  
  self.watcher = uv.new_fs_event()
  
  -- Referência local para evitar problemas de escopo no closure
  local tracker = self

  -- IMPORTANTE: { recursive = true } para detectar arquivos dentro de pastas
  self.watcher:start(self.path, { recursive = true }, vim.schedule_wrap(function(err, filename)
    if err then
      dlog.dotnet_log("Erro no Watcher: " .. err, "error")
      return
    end

    -- Só dispara o update se o arquivo alterado for relevante
    -- Isso evita processamento inútil em cada save de arquivo .cs
    if filename and (filename:match("%.csproj$") or filename:match("%.sln$")) then
      dlog.dotnet_log("Mudança detectada no projeto: " .. filename)
      tracker:update_context_from_dir()
    end
  end))
end

function FSWatcher:stop()
  if self.watcher then
    self.watcher:stop()
    if not self.watcher:is_closing() then
      self.watcher:close()
    end
    self.watcher = nil
    
    ContextActions.set_current_solution(nil)
    ContextActions.set_current_project({})
    dlog.dotnet_log("FSWatcher stopped")
  end
end

return FSWatcher

local dlog = require("dotnet.internal.dotnet_log")

local Context = {}
Context.context = {
  current_solution = nil, -- inicialmente nenhuma solução
  projects = {}           -- lista de projetos do diretório atual
}


return Context

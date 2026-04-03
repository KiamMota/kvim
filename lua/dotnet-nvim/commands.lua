-- ~/.config/nvim/lua/csharp/core/commands.lua
local Actions = require("dotnet.core.project_actions")
local Context = require("dotnet.core.context_actions")
local dlog = require("dotnet.internal.dotnet_log")
local unpack = table.unpack or unpack  -- compatibilidade Lua 5.1 / Neovim

-- Função utilitária para registrar comandos do Neovim chamando actions
local function register_action(name, action_fn, nargs)
  vim.api.nvim_create_user_command(name, function(opts)
    local args = opts.fargs or {}
    action_fn(unpack(args))
  end, { nargs = nargs })
end

-- Comandos registrados ao carregar o módulo
register_action("DotNetNewConsole", Actions.new_console, 1)
register_action("DotNetNewClassLib", Actions.new_classlib, 1)
register_action("DotNetNewSolution", Actions.new_solution, 1)
register_action("DotNetNewAspNet", Actions.new_aspnet, 1)
register_action("DotNetNewAspNetMvc", Actions.new_aspnet_mvc, 1)

register_action("DotNetBuild", Actions.build, "*")
register_action("DotNetRun", Actions.run, "*")

register_action("DotNetAddReference", Actions.add_reference, "+")
register_action("DotNetSolutionAddProject", Actions.solution_add_project, "+")
register_action("DotNetReferenceList", Actions.reference_list, 0)

register_action("DotNetContextGetProject", function() 
  local project = Context.get_current_project()
  if project and #project > 0 then
    -- Convertemos a tabela para string para o log aceitar
    dlog.dotnet_log("Current Project Path: " .. project[1]) 
  else
    dlog.dotnet_log("No project in context", "warn")
  end
end, 0)

-- Action para a Solução
register_action("DotNetContextGetSolution", function() 
  local solution = Context.get_current_solution()
  if solution then
    dlog.dotnet_log("Current Solution Path: " .. solution)
  else
    dlog.dotnet_log("No solution in context", "warn")
  end
end, 0)

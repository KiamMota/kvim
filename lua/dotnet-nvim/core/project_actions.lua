-- ~/.config/nvim/lua/dotnet.core/actions.lua
local M = {}
local Terminal = require("dotnet.internal.terminal_command")
local ContextActions = require("dotnet.core.context_actions") -- usar somente o actions

-- Função auxiliar para atualizar contexto depois de criar algo
local function update_context_after_creation(path)
  if path:match("%.sln$") then
    ContextActions.set_current_solution(path)
  elseif path:match("%.csproj$") then
    ContextActions.set_current_project({vim.fn.fnamemodify(path, ":h")})
  else
    -- fallback: trata como pasta de projeto
    ContextActions.set_current_project({path})
  end
end

function M.new_console(name)
  local proj_path = Terminal.exec_dotnet(
    { "new", "console", "--name", "$1" },
    { name },
    { show_output = true }
  )
  update_context_after_creation(name)
  return proj_path
end

function M.new_classlib(name)
  local proj_path = Terminal.exec_dotnet(
    { "new", "classlib", "--name", "$1" },
    { name },
    { show_output = true }
  )
  update_context_after_creation(name)
  return proj_path
end

function M.new_solution(name)
  local sol_path = Terminal.exec_dotnet(
    { "new", "sln", "--name", "$1" },
    { name },
    { show_output = true }
  )
  update_context_after_creation(name .. ".sln")
  return sol_path
end

function M.new_aspnet(name)
  local proj_path = Terminal.exec_dotnet(
    { "new", "web", "--name", "$1" },
    { name },
    { show_output = true }
  )
  update_context_after_creation(name)
  return proj_path
end

function M.new_aspnet_mvc(name)
  local proj_path = Terminal.exec_dotnet(
    { "new", "mvc", "--name", "$1" },
    { name },
    { show_output = true }
  )
  update_context_after_creation(name)
  return proj_path
end

function M.build(project)
  if project and project ~= "" then
    local result = Terminal.exec_dotnet(
      { "build", "$1" },
      { project },
      { show_output = true }
    )
    update_context_after_creation(project)
    return result
  end

  return Terminal.exec_dotnet({ "build" }, {}, { show_output = true })
end

function M.run(project)
  if project and project ~= "" then
    local result = Terminal.exec_dotnet(
      { "run", "--project", "$1" },
      { project },
      { show_output = true }
    )
    update_context_after_creation(project)
    return result
  end

  return Terminal.exec_dotnet({ "run" }, {}, { show_output = true })
end

function M.add_reference(console_project, classlib_project)
  local result = Terminal.exec_dotnet(
    { "add", "$1", "reference", "$2" },
    { console_project, classlib_project },
    { show_output = true }
  )
  update_context_after_creation(console_project)
  return result
end

function M.solution_add_project(solution, project)
  local result = Terminal.exec_dotnet(
    { "sln", "$1", "add", "$2" },
    { solution, project },
    { show_output = true }
  )
  update_context_after_creation(solution)
  return result
end

function M.list_references(project)
  local args = { "reference", "list", "--project", project .. "/" .. project .. ".csproj" }
  Terminal.create_dotnet_command(nil, args, { show_output = true })
end

return M

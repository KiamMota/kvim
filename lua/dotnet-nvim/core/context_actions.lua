local M = {}
local Context = require("dotnet.core.the_context")
local dlog = require("dotnet.internal.dotnet_log")  -- import do logger

function M.get_current_solution()
  return Context.context.current_solution 
end

function M.get_solution_name()
  local solution = Context.context.current_solution
  if solution then
    return vim.fn.fnamemodify(solution, ":t")
  end
  return nil
end

function M.get_project_name()
  local projects = Context.context.projects
  if projects then
    local names = {}
    for _, path in ipairs(projects) do
      table.insert(names, vim.fn.fnamemodify(path, ":t"))
    end
    return names
  end
  return nil
end

function M.get_current_project()
  return Context.context.projects
end

function M.get_current_project_name()
  local projects = Context.context.projects
  if projects then
    return table.concat(vim.tbl_map(function(path)
      return vim.fn.fnamemodify(path, ":t")
    end, projects), ", ")
  end
  return ""
end

function M.set_current_solution(solution)
  Context.context.current_solution = solution
  if solution then
    dlog.dotnet_log("Current solution set to: " .. vim.fn.fnamemodify(solution, ":t"))
  else
    dlog.dotnet_log("Current solution cleared")
  end
end

function M.set_current_project(project)
  Context.context.projects = project or {}
  if project and #project > 0 then
    dlog.dotnet_log("Current project(s) set to: " .. table.concat(vim.tbl_map(function(p)
      return vim.fn.fnamemodify(p, ":t")
    end, project), ", "))
  else
    dlog.dotnet_log("Current project(s) cleared")
  end
end

return M

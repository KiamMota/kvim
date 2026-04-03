-- ~/.config/nvim/lua/dotnet.registry.lua
local M = {}

M.actions = {}

-- Registrar uma action
function M.register_action(name, fn)
  M.actions[name] = fn
end

-- Executar uma action
function M.run_action(name, user_opts)
  local action = M.actions[name]
  if not action then
    vim.notify("Action not found: " .. name, vim.log.levels.ERROR)
    return
  end
  return action(user_opts)
end

-- Registrar um comando que chama a action
function M.register_command(command_name, action_name, opts)
  opts = opts or {}
  vim.api.nvim_create_user_command(command_name, function(user_opts)
    M.run_action(action_name, user_opts)
  end, opts)
end

return M

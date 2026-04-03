vim.api.nvim_set_hl(0, "DotNetPrefix", {
  fg = "#FFFFFF",
  bg = "#512BD4",
  bold = true,
})

local M = {}

function M.dotnet_log(message, level)
  level = level or "info"
  local prefix = " .NET "
  local msg = prefix .. message

  local hl = "Normal"
  if level == "warn" then hl = "WarningMsg"
  elseif level == "error" then hl = "ErrorMsg" end

  vim.api.nvim_echo({
    { prefix, "DotNetPrefix" },
    { " " .. message, hl }
  }, true, {})  -- true = nova linha
end

-- Notificação flutuante (requires nvim-notify se quiser popup)
function M.dotnet_notify(message, level)
  level = level or "info"
  local prefix = " .NET "
  local msg = prefix .. message

  local log_level = vim.log.levels.INFO
  if level == "warn" then log_level = vim.log.levels.WARN
  elseif level == "error" then log_level = vim.log.levels.ERROR end

  -- Se tiver nvim-notify instalado, ele será usado automaticamente
  vim.notify(msg, log_level, {
    title = "DotNet",
    timeout = 3000,
    render = "minimal",
  })
end

return M

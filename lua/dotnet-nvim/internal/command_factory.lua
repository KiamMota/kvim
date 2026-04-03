local M = {}
local TerminalCommand = require("dotnet.internal.terminal_command")

-- Função para criar múltiplos comandos de uma vez
-- commands: tabela com { name = "NomeDoComando", args = {…}, opts = {…} }
function M.create_commands(commands)
  for _, cmd_def in ipairs(commands) do
    TerminalCommand.create_dotnet_command(
      cmd_def.name,
      cmd_def.args or {},
      cmd_def.opts or {}
    )
  end
end

return M

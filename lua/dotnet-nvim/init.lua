local M = {}
local dlog = require("dotnet-nvim.internal.dotnet_log")
local pipe = require("dotnet-nvim.internal.pipe_client")

-- Removi o M._watcher pois o gerenciamento de estado agora 
-- acontece via conexão de Socket/Pipe no daemon C#.

function M.setup(opts)
  -- 1. Carrega os módulos de lógica e comandos
  require("dotnet-nvim.core.project_actions")
  require("dotnet-nvim.commands")

  -- 2. Inicializa a conexão com o Daemon .NET
  -- O pipe.connect() vai tentar abrir o socket em /tmp/CoreFxPipe_...
  pipe.connect()

  -- 3. Configura o gatilho para atualizar o PWD no Daemon
  -- Sempre que você mudar de pasta ou abrir o Neovim, o C# será avisado
  vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter" }, {
    group = vim.api.nvim_create_augroup("DotnetDaemonSync", { clear = true }),
    callback = function()
      pipe.send_pwd()
    end
  })

  -- Log de confirmação
  local root_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
  dlog.dotnet_log("Dotnet Provider Client initialized. Root: " .. root_dir)
end

--- Função para encerrar a conexão manualmente se necessário
function M.stop_client()
  pipe.disconnect()
end

return M

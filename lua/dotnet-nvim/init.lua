local M = {}

function M.setup(opts)
  local client = require("dotnet-nvim.client.init_server")
  local chan = client.start()  -- inicia o servidor RPC

  -- Teste simples: envia ping
  local rpc = require("dotnet-nvim.client.send_request")
  local result = rpc.send_request(chan, "ping")
  print(vim.inspect(result))
end

return M

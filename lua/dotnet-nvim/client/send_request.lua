-- send_request.lua
local M = {}

-- Recebe o channel do servidor .NET iniciado pelo client.lua
-- Exemplo: local chan = require("client").start()
function M.send_request(chan, method, ...)
    if not chan then
        error("Channel inválido. Inicie o servidor primeiro com client.start()")
    end

    local ok, result = pcall(vim.rpcrequest, chan, method, ...)
    if ok then
        return result
    else
        vim.notify("Erro RPC: " .. tostring(result))
        return nil
    end
end

-- Envia notificação assíncrona (fire-and-forget)
function M.send_notify(chan, method, ...)
    if not chan then
        error("Channel inválido. Inicie o servidor primeiro com client.start()")
    end

    vim.rpcnotify(chan, method, ...)
end

return M

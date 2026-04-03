local M = {}
local dlog = require("dotnet-nvim.internal.dotnet_log")
-- O .NET no Linux adiciona esse prefixo ao socket
local PIPE_PATH = "/tmp/CoreFxPipe_dotnet-nvim-ctx"
local client = nil

-- Tabela interna para manter o estado do contexto atualizado
M.state = {
    project_path = nil,
    solution_path = nil,
    status = "disconnected"
}

--- Tenta conectar ao Daemon C#
function M.connect()
    if client then 
        client:close() 
    end

    -- Cria o handle do pipe
    client = vim.uv.new_pipe(false)

    -- Tenta conectar ao caminho absoluto
    client:connect(PIPE_PATH, function(err)
        if err then
            M.state.status = "disconnected"
            -- Isso vai fazer aparecer uma mensagem vermelha no Neovim
            vim.schedule(function()
                vim.api.nvim_err_writeln("ERRO DOTNET-PIPE: " .. tostring(err))
            end)
            return
        end

        -- Se chegou aqui, conectou!
        M.state.status = "connected"
        vim.schedule(function()
            dlog.dotnet_log("DotNet provider are connected.")
            M.send_pwd()
        end)

        client:read_start(function(read_err, data)
            if read_err then
                M.disconnect()
                return
            end
            if data then 
                M.handle_response(data) 
            end
        end)
    end)
end

--- Trata o JSON recebido do Daemon
function M.handle_response(raw_data)
    local ok, decoded = pcall(vim.json.decode, raw_data)
    if not ok then return end

    vim.schedule(function()
        -- Se o C# mandar um update de contexto
        if decoded.type == "update_context" or decoded.project_path then
            -- Atualizamos o estado local do módulo
            M.state.project_path = decoded.project_path
            M.state.solution_path = decoded.solution_path
            
            -- Aqui você pode disparar um log ou um evento customizado
            dlog.dotnet_log("Contexto atualizado: " .. (M.state.project_path or "Nenhum projeto"))
            
            -- Se você quiser que outros componentes saibam da mudança:
            vim.api.nvim_exec_autocmds("User", { pattern = "DotnetContextUpdated" })
        end
    end)
end

--- Envia o diretório atual para o Daemon analisar
--- Envia apenas a string do diretório atual para o Daemon
function M.send_pwd()
    if client and not client:is_closing() then
        -- Pegamos o PWD atual
        local pwd = vim.fn.getcwd()
        
        -- Enviamos apenas a string pura seguida de \n
        -- O \n é o que faz o ReadLineAsync() do C# destravar
        client:write(pwd .. "\n")
        
        -- Log opcional para você conferir no Neovim
        -- dlog.dotnet_log("Enviando PWD: " .. pwd)
    end
end

function M.disconnect()
    if client then
        client:read_stop()
        client:close()
        client = nil
        M.state.status = "disconnected"
        dlog.dotnet_log("Conexão com Daemon encerrada", "warn")
    end
end

--- Getter para o resto do plugin consultar o estado atual
function M.get_context()
    return M.state
end

return M

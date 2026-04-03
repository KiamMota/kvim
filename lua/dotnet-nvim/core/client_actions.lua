local M = {}
local dlog = require("dotnet-nvim.internal.dotnet_log")
local client = require("dotnet-nvim.internal.pipe_client")

--- Exibe o status atual da conexão e o contexto do projeto
function M.show_status()
    local state = client.get_context()
    
    -- Usando símbolos Unicode (● para status, ━ para divisórias)
    local status_symbol = state.status == "connected" and "●" or "○"
    local status_text = state.status:upper()
    
    local lines = {
        "  " .. status_symbol .. " Dotnet Daemon: " .. status_text,
        "  " .. string.rep("─", 40),
        "  Project: " .. (state.project_path or "None"),
        "  Solution: " .. (state.solution_path or "None"),
        "  " .. string.rep("─", 40),
    }
    
    -- Imprime no command line
    print("\n" .. table.concat(lines, "\n"))
end

--- Abre um prompt para o usuário mandar uma mensagem manual (string pura)
function M.send_raw_message()
    vim.ui.input({ prompt = '[-] Message to Daemon: ' }, function(input)
        if input and input ~= "" then
            client.send_raw(input)
            print("\n[sent] " .. input)
        end
    end)
end

--- Força uma tentativa de reconexão
function M.reconnect()
    dlog.dotnet_log("Manual reconnection triggered.")
    client.connect()
end

--- Abre o arquivo de log do plugin
function M.open_logs()
    local log_path = vim.fn.stdpath("cache") .. "/dotnet-nvim.log"
    if vim.fn.filereadable(log_path) == 1 then
        vim.cmd("edit " .. log_path)
    else
        print("[!] Log file not found at: " .. log_path)
    end
end

return M

local M = {}

function M.setup()
    -- Dicionários de pares
    local brackets = { ['('] = ')', ['['] = ']', ['{'] = '}' }
    local quotes = { ['"'] = '"', ["'"] = "'", ['`'] = '`' }

    -- 1. Abertura de parênteses, colchetes e chaves
    for open, close in pairs(brackets) do
        vim.keymap.set('i', open, open .. close .. '<Left>')
    end

    -- 2. Fechamento (Pular caso já exista)
    for _, close in pairs(brackets) do
        vim.keymap.set('i', close, function()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local line = vim.api.nvim_get_current_line()
            local next_char = line:sub(col + 1, col + 1)
            
            if next_char == close then
                return '<Right>' -- Pula sobre o caractere
            end
            return close -- Apenas insere o caractere
        end, { expr = true, replace_keycodes = true })
    end

    -- 3. Lógica das Aspas (Abre, fecha e salta)
    for _, quote in pairs(quotes) do
        vim.keymap.set('i', quote, function()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local line = vim.api.nvim_get_current_line()
            local next_char = line:sub(col + 1, col + 1)

            -- Se a próxima letra já for a aspa, apenas pula
            if next_char == quote then
                return '<Right>'
            end
            
            -- Inteligência: Evita criar o par se a próxima letra for alfanumérica 
            -- (ex: não cria par se você digitar aspas logo antes de uma palavra)
            if next_char:match("[%w]") then
                return quote
            end

            return quote .. quote .. '<Left>'
        end, { expr = true, replace_keycodes = true })
    end

    -- 4. Backspace inteligente (Deleta o par inteiro se estiver vazio)
    vim.keymap.set('i', '<BS>', function()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        if col == 0 then return '<BS>' end -- Previne erro no começo da linha

        local line = vim.api.nvim_get_current_line()
        local prev_char = line:sub(col, col)
        local next_char = line:sub(col + 1, col + 1)

        -- Verifica se estamos exatamente no meio de um par válido
        local is_pair = (brackets[prev_char] == next_char) or (quotes[prev_char] == next_char)

        if is_pair then
            return '<Right><BS><BS>'
        end
        return '<BS>'
    end, { expr = true, replace_keycodes = true })

    -- 5. Enter inteligente (Expande blocos)
    vim.keymap.set('i', '<CR>', function()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local line = vim.api.nvim_get_current_line()
        local prev_char = line:sub(col, col)
        local next_char = line:sub(col + 1, col + 1)

        -- Se der Enter dentro de () [] ou {}, quebra a linha com indentação
        if brackets[prev_char] == next_char then
            return '<CR><C-o>O'
        end
        return '<CR>'
    end, { expr = true, replace_keycodes = true })
end

return M

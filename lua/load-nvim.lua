local M = {}

local first_pwd = nil

local function get_session_file()
  local target_dir = first_pwd or vim.fn.getcwd()
  local cwd = target_dir:gsub("[/\\]", "%%")
  return vim.fn.stdpath("data") .. "/session_" .. cwd .. ".vim"
end

function M.save_session()
  local session_file = get_session_file()

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local name = vim.api.nvim_buf_get_name(buf)

      if name:match("^oil://") then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end

  vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))
end

function M.load_session()
  local session_file = get_session_file()
  if vim.fn.filereadable(session_file) == 1 then
    vim.cmd('source ' .. vim.fn.fnameescape(session_file))
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("AutoSessionManagement", { clear = true })

  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = group,
    once = true, -- Executa apenas uma vez por inicialização
    callback = function()
      if vim.bo.buftype == "" then
        first_pwd = vim.fn.getcwd()
      end
    end,
  })

  vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    nested = true, -- Permite que outros plugins carreguem corretamente junto
    callback = function()
      -- Só carrega se o Neovim foi aberto sem argumentos (ex: apenas `nvim`)
      if vim.fn.argc() == 0 then
        M.load_session()
      end
    end,
  })

  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
      M.save_session()
    end,
  })
end


return M

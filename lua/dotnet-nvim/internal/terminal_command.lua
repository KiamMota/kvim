-- ~/.config/nvim/lua/dotnet.internal/terminal_command_exec.lua
local M = {}
local Loading = require("dotnet.internal.dotnet_loading")

local config = {
  messages = {
    success = "Command executed successfully!",
    error = "Error executing command.",
    running = "Running command...",
  },
  notify_levels = {
    info = vim.log.levels.INFO,
    error = vim.log.levels.ERROR,
    warn = vim.log.levels.WARN,
  },
}

-- Coletor de output
local OutputCollector = {}
OutputCollector.__index = OutputCollector

function OutputCollector.new()
  local self = setmetatable({}, OutputCollector)
  self.stdout_lines = {}
  self.stderr_lines = {}
  return self
end

function OutputCollector:add_stdout(data)
  if data then
    for _, line in ipairs(data) do
      if line ~= "" then
        table.insert(self.stdout_lines, line)
      end
    end
  end
end

function OutputCollector:add_stderr(data)
  if data then
    for _, line in ipairs(data) do
      if line ~= "" then
        table.insert(self.stderr_lines, line)
      end
    end
  end
end

function OutputCollector:has_output()
  return #self.stdout_lines > 0 or #self.stderr_lines > 0
end

-- Executor de comandos
local CommandExecutor = {}
CommandExecutor.__index = CommandExecutor

function CommandExecutor.new(command, args, opts)
  local self = setmetatable({}, CommandExecutor)
  self.command = command
  self.args = args or {}
  self.opts = opts or {}
  self.full_cmd = { command }
  vim.list_extend(self.full_cmd, self.args)
  return self
end

function CommandExecutor:execute(on_complete)
  local output = OutputCollector.new()
  local pwd = vim.fn.getcwd()

  local loading = Loading.new("Running dotnet " .. table.concat(self.args, " ") .. "...")
  loading:start()

  local job_id = vim.fn.jobstart(self.full_cmd, {
    stdout_buffered = false,
    stderr_buffered = false,

    on_exit = vim.schedule_wrap(function(_, exit_code, _)
      loading:stop()

      local success = exit_code == 0
      local msg = success and (self.opts.success_message or config.messages.success)
                        or (self.opts.error_message or config.messages.error)
      local level = success and config.notify_levels.info or config.notify_levels.error
      vim.notify(msg, level)

      if self.opts.show_output and output:has_output() then
        if #output.stdout_lines > 0 then
          vim.notify(table.concat(output.stdout_lines, "\n"), config.notify_levels.info)
        end
        if #output.stderr_lines > 0 then
          vim.notify(table.concat(output.stderr_lines, "\n"), config.notify_levels.error)
        end
      end

      if on_complete then
        on_complete({ pwd = pwd, success = success })
      end
    end),

    on_stdout = vim.schedule_wrap(function(_, data)
      output:add_stdout(data)
      if self.opts.realtime_log then
        for _, line in ipairs(data or {}) do
          if line ~= "" then print(line) end
        end
      end
    end),

    on_stderr = vim.schedule_wrap(function(_, data)
      output:add_stderr(data)
      if self.opts.realtime_log then
        for _, line in ipairs(data or {}) do
          if line ~= "" then print("ERR: " .. line) end
        end
      end
    end),
  })

  return job_id
end

-- Constrói args substituindo placeholders $1, $2 etc.
local function build_args(template, user_args)
  local out = {}
  local used = {}
  for _, part in ipairs(template or {}) do
    local index = part:match("^%$(%d+)$")
    if index then
      index = tonumber(index)
      local value = user_args and user_args[index]
      if value ~= nil then
        table.insert(out, value)
        used[index] = true
      end
    else
      table.insert(out, part)
    end
  end
  if user_args then
    for i, value in ipairs(user_args) do
      if not used[i] then table.insert(out, value) end
    end
  end
  return out
end

-- Função principal para executar dotnet diretamente
function M.exec_dotnet(template_args, user_args, opts, on_complete)
  opts = opts or {}
  local all_args = build_args(template_args, user_args)
  local executor = CommandExecutor.new("dotnet", all_args, opts)
  return executor:execute(on_complete)
end

function M.setup(user_config)
  config = vim.tbl_deep_extend("force", config, user_config or {})
end

return M

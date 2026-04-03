-- loading.lua
local M = {}

local config = {
  frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
  interval = 100,
}

-- Criar o highlight group com o roxo oficial da .NET
vim.api.nvim_set_hl(0, "DotNetPrefix", {
  bg = "#512BD4",  -- Roxo oficial da .NET
  fg = "#FFFFFF",  -- Branco
  bold = true,
})

local LoadingAnimation = {}
LoadingAnimation.__index = LoadingAnimation

function LoadingAnimation.new(message, frames, interval)
  local self = setmetatable({}, LoadingAnimation)
  self.message = message
  self.frames = frames or config.frames
  self.interval = interval or config.interval
  self.current_frame = 1
  self.timer = vim.loop.new_timer()
  return self
end

function LoadingAnimation:start()
  self.timer:start(0, self.interval, vim.schedule_wrap(function()
    local frame = self.frames[self.current_frame]
    vim.cmd("echohl DotNetPrefix | echon ' .NET ' | echohl Normal | echon ' " .. 
            frame .. " " .. self.message .. "'")
    self.current_frame = self.current_frame + 1
    if self.current_frame > #self.frames then
      self.current_frame = 1
    end
  end))
end

function LoadingAnimation:stop()
  self.timer:stop()
  self.timer:close()
  vim.cmd("echo ''")
end

-- Interface pública
function M.new(message, opts)
  opts = opts or {}
  return LoadingAnimation.new(message, opts.frames, opts.interval)
end

function M.setup(user_config)
  config = vim.tbl_deep_extend("force", config, user_config or {})
end

return M

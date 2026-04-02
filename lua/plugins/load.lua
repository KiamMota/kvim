-- lua/plugins/load.lua

local plugin_dir = vim.fn.stdpath('config') .. '/lua/plugins'

for _, file in ipairs(vim.fn.glob(plugin_dir .. '/*.lua', false, true)) do
  local name = vim.fn.fnamemodify(file, ':t:r')
  if name ~= 'load' then
    require('plugins.' .. name)
  end
end
local M = {}

local function script_dir()
  local src = debug.getinfo(1, "S").source:sub(2)
  return vim.fs.dirname(src)
end

local function server_dir()
  return vim.fs.normalize(vim.fs.joinpath(
    script_dir(),
    "..",
   "server",
    "DotnetNvimServer",
    "src"
  ))
end

local function csproj_path()
  return vim.fs.joinpath(server_dir(), "DotnetNvimServer.csproj")
end

function M.start()
  local proj = csproj_path()

  local chan = vim.fn.jobstart({ "dotnet", "run", "--project", proj }, {
    rpc = true,
    on_stderr = function(_, data)
      if data and #data > 0 then
        vim.schedule(function()
          vim.print(table.concat(data, "\n"))
        end)
      end
    end,
    on_exit = function(_, code)
      vim.schedule(function()
        vim.notify("dotnet server saiu com code=" .. code)
      end)
    end,
  })

  if chan <= 0 then
    error("falha ao iniciar o servidor .NET")
  end

  return chan
end

return M

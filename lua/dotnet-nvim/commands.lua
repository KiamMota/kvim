-- ~/.config/nvim/lua/dotnet-nvim/commands.lua
local Actions = require("dotnet-nvim.core.project_actions")
local ClientActions = require("dotnet-nvim.core.client_actions") -- The new module we created
local dlog = require("dotnet-nvim.internal.dotnet_log")
local unpack = table.unpack or unpack 

-- Utility function to register Neovim commands calling actions
local function register_action(name, action_fn, nargs, desc)
  vim.api.nvim_create_user_command(name, function(opts)
    local args = opts.fargs or {}
    action_fn(unpack(args))
  end, { nargs = nargs, desc = desc })
end

--- Standard Project Actions
register_action("DotNetNewConsole", Actions.new_console, 1, "Create a new console project")
register_action("DotNetNewClassLib", Actions.new_classlib, 1, "Create a new class library")
register_action("DotNetNewSolution", Actions.new_solution, 1, "Create a new solution file")
register_action("DotNetNewAspNet", Actions.new_aspnet, 1, "Create a new ASP.NET project")
register_action("DotNetNewAspNetMvc", Actions.new_aspnet_mvc, 1, "Create a new ASP.NET MVC project")

register_action("DotNetBuild", Actions.build, "*", "Build the current project")
register_action("DotNetRun", Actions.run, "*", "Run the current project")

register_action("DotNetAddReference", Actions.add_reference, "+", "Add a reference to the project")
register_action("DotNetSolutionAddProject", Actions.solution_add_project, "+", "Add a project to the solution")
register_action("DotNetReferenceList", Actions.reference_list, 0, "List project references")

--- Daemon & Pipe Management
register_action("DotNetStatus", ClientActions.show_status, 0, "Show Daemon connection status")
register_action("DotNetReconnect", ClientActions.reconnect, 0, "Reconnect to the .NET Daemon")
register_action("DotNetMsg", ClientActions.send_raw_message, 0, "Send a raw message to the Daemon")
register_action("DotNetLogs", ClientActions.open_logs, 0, "Open plugin log file")

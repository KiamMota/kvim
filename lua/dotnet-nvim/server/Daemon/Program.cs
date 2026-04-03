using DotNetNvim.Provider.Gateway;

var builder = Host.CreateApplicationBuilder(args);
builder.Services.AddHostedService<DotnetProviderDaemon>();

var host = builder.Build();
host.Run();

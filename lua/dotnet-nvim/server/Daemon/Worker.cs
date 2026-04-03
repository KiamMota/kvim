namespace Daemon;

using System.IO.Pipes;

public class DotnetProviderDaemon : BackgroundService
{
    private readonly ILogger<DotnetProviderDaemon> _logger;

    public DotnetProviderDaemon(ILogger<DotnetProviderDaemon> logger)
    {
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        string pipeName = "dotnet-nvim-ctx";

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                using var server = new NamedPipeServerStream(
                    pipeName,
                    PipeDirection.InOut,
                    1,
                    PipeTransmissionMode.Byte,
                    PipeOptions.Asynchronous);

                _logger.LogInformation("Aguardando Neovim...");
                await server.WaitForConnectionAsync(stoppingToken);

                Console.WriteLine("conectado!");
            }
            catch (OperationCanceledException) { break; }
            catch (Exception ex) { _logger.LogError(ex, "Erro no Pipe"); }
        }
    }


}

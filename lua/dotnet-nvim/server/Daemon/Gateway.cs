namespace DotNetNvim.Provider.Gateway;

using System.IO.Pipes;
using DotNetNvim.Provider;

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

                _logger.LogInformation("Neovim Conectado!");

                using var reader = new StreamReader(server);
                using var writer = new StreamWriter(server) { AutoFlush = true };

                // LOOP DE SESSÃO: Mantém o canal aberto
                while (server.IsConnected && !stoppingToken.IsCancellationRequested)
                {
                    var line = await reader.ReadLineAsync();

                    if (line == null) break; // Neovim desconectou

                    _logger.LogInformation("Recebido: {line}", line);

                    // Opcional: Responder ao Neovim para confirmar
                    // await writer.WriteLineAsync("OK"); 
                }

                _logger.LogInformation("Neovim desconectou. Reiniciando servidor...");
            }
            catch (IOException ex)
            {
                _logger.LogWarning("Conexão interrompida: {msg}", ex.Message);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro no Pipe");
            }
        }
    }


}

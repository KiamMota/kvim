using DotnetNvimServer.Server;
namespace DotnetNvimServer;

public class Program
{
    public static async Task Main()
    {

        var server = new MessagePackServer(Console.OpenStandardInput(), Console.OpenStandardOutput());
        await server.RunAsync();
    }
}

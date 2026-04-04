using MessagePack;

public class Program
{
    public static async Task Main(string[] args)
    {
        Console.WriteLine("started IO.");

        var server = new MessagePackServer();
        await server.RunAsync();
    }

}
public static class InputInterceptor
{
    public static async Task<string> GetStringFromStream(Stream stream)
    {
        using (StreamReader reader = new StreamReader(stream, System.Text.Encoding.UTF8))
        {
            return await reader.ReadToEndAsync();
        }
    }
}
public class MessagePackServer
{
    private readonly Stream _input;
    private readonly Stream _output;
    private readonly MessagePackStreamReader _reader;
    public MessagePackServer()
    {
        _input = Console.OpenStandardInput();
        _output = Console.OpenStandardOutput();
        _reader = new MessagePackStreamReader(_input);

        Console.WriteLine("started message pack reader.");
    }



    private async Task<byte[]> BuildResponse(int messageId, string error, object result)
    {
        var response = new object[]
      {
        1,
        messageId,
        error,
        result
      };

        return MessagePackSerializer.Serialize(response);
    }

    public async Task RunAsync()
    {
        while (true)
        {
            var read = await _reader.ReadAsync(CancellationToken.None);
            if (read == null)
                break;

            try
            {
                var msg = MessagePackSerializer.Deserialize<object[]>(read.Value);

                Console.WriteLine(string.Join(", ", msg));
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"[server error]: {ex.Message}");
                Console.WriteLine("aborted.");
            }
        }
    }
}

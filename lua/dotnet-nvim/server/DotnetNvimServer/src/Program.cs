using DotnetNvimServer.MessagePackRpc;
using MessagePack;


namespace DotnetNvimServer.Server;

public class MessagePackServer
{
    private readonly Stream _input;
    private readonly Stream _output;

    public MessagePackServer(Stream input, Stream output)
    {
        _input = input;
        _output = output;
    }

    public async Task RunAsync()
    {
        var reader = new MessagePackStreamReader(_input);

        while (true)
        {
            var readResult = await reader.ReadAsync(CancellationToken.None);
            if (readResult == null) break; // fim do stream

            try
            {
                var msgReader = new MessagePackReader(readResult.Value);
                var request = MsgPackRpcRequest.Decode(ref msgReader);


                var response = await MsgPackRpcResponse.BuildResponse(request.MessageId, null, "pong");
                await _output.WriteAsync(response, 0, response.Length);
                await _output.FlushAsync();
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"[server error]: {ex.Message}");
            }
        }
    }
}

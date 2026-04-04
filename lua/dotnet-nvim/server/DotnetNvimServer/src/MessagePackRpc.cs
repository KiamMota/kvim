using MessagePack;
namespace DotnetNvimServer.MessagePackRpc;

public class MsgPackRpcRequest
{
    public int MessageType { get; set; }
    public int MessageId { get; set; }
    public string MethodName { get; set; } = string.Empty;
    public List<string> Args { get; set; } = new();

    public static MsgPackRpcRequest Decode(ref MessagePackReader reader)
    {
        var req = new MsgPackRpcRequest();
        reader.ReadArrayHeader(); // 4 elementos esperados

        req.MessageType = reader.ReadInt32();
        req.MessageId = reader.ReadInt32();
        req.MethodName = reader.ReadString();

        int argsCount = reader.ReadArrayHeader();
        req.Args = new List<string>(argsCount);
        for (int i = 0; i < argsCount; i++)
        {
            req.Args.Add(reader.ReadString());
        }

        return req;
    }
}

public static class MsgPackRpcResponse
{
    public static async Task<byte[]> BuildResponse(int messageId, object? error, object result)
    {
        var response = new object[]
        {
          1,          // MessageType = response
          messageId,  // mesmo ID da request
          error,      // erro ou null
          result      // resultado da chamada
        };

        return MessagePackSerializer.Serialize(response);
    }
}

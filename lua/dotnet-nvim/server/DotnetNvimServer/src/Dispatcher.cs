namespace DotnetNvimServer.Dispatcher;

public class Dispatcher
{
    private readonly Dictionary<string, Func<object[]?, object?>> _handlers = new();
    public object? Dispatch(string method, object[]? args)
    {
        if (!_handlers.TryGetValue(method, out var handler))
        {
            throw new Exception("method not setted!");
        }
        return handler(args);
    }

    public void Register(string name, Func<object[]?, object?> handler)
    {
        if (string.IsNullOrWhiteSpace(name))
            throw new ArgumentException("name is required", nameof(name));

        _handlers[name] = handler;
    }
}

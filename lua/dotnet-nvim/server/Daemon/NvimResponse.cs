namespace DotNetNvim.Provider;

public class NeovimResponse
{
    public string Type { get; set; } = "update_context";
    public string Data { get; set; } = "";
    public string Status { get; set; } = "success";
}

using MagicOnion;
using MessagePack;

namespace G.Shared.Services
{
    /// <summary>
    /// Client -> Server API
    /// </summary>
    public interface IChatService : IService<IChatService>
    {
        UnaryResult<Nil> GenerateException(string message);
        UnaryResult<Nil> SendReportAsync(string message);
    }
}

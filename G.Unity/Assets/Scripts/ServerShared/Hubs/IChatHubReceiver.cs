using G.Shared.MessagePackObjects;

namespace G.Shared.Hubs
{
    /// <summary>
    /// Server -> Client API
    /// </summary>
    public interface IChatHubReceiver
    {
        void OnJoin(string name);

        void OnLeave(string name);

        void OnSendMessage(MessageResponse message);
    }
}

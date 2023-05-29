using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace FreelanceServer
{
    internal class ConnectedUser
    {
        public TcpClient Client { get; set; }
        public string UserName { get; set; }
        public int UserId { get; set; }

        public ConnectedUser() { }
        public ConnectedUser(TcpClient client, string userName, int userId)
        {
            Client = client;
            UserName = userName;
            UserId = userId;
        }
    }
}

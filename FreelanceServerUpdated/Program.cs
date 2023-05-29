// See https://aka.ms/new-console-template for more information
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using MySql.Data.MySqlClient;
using FreelanceServer;

string ConnectionString = "server=localhost;username=root;database=freelanceplatformdb;uid=root;charset=utf8";

TcpListener server = new TcpListener(IPAddress.Any, 8888);
List<ConnectedUser> users = new List<ConnectedUser>();


server.Start();
Console.WriteLine("Server started!");
while (true)
{
    ConnectedUser client = new ConnectedUser();
    client.Client = server.AcceptTcpClient();

    Task.Run(() =>
    {
        var streamReader = new StreamReader(client.Client.GetStream());
        while (client.Client.Connected)
        {
            var line = streamReader.ReadLine();
            if (line != null)
            {
                Console.WriteLine(line);
                if (line.Contains("Connect^"))
                {
                    string[] inputs = line.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                    int UserId = int.Parse(inputs[1]);
                    string UserName = inputs[2];

                    if (users.Count(x => x.UserId == UserId) == 0)
                    {
                        users.Add(new ConnectedUser(client.Client, UserName, UserId));
                        client.UserName = UserName;
                        client.UserId = UserId;
                        Console.WriteLine("User " + UserName + " (" + UserId + ") connected!");
                    }
                }

                if (line.Contains("Create^"))
                {
                    string[] msg = line.Split(new string[] { "msg:" }, StringSplitOptions.RemoveEmptyEntries);
                    string[] inputs = msg[0].Split(new string[] { "<", ">" }, StringSplitOptions.RemoveEmptyEntries);

                    string topic = inputs[1];
                    string id = inputs[0].Split()[0];
                    inputs = inputs[2].Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                    if (users.Count(x => x.UserId == int.Parse(id)) > 0)
                    {
                        List<int> ids = new List<int>();
                        for (int i = 0; i < inputs.Length; i++)
                        {
                            ids.Add(int.Parse(inputs[i]));
                        }
                        Console.WriteLine("start creating");
                        CreateChat(topic, ids, msg[1], int.Parse(id));

                    }
                }

                if (line.Contains("Send^"))
                {
                    string[] inputs = line.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                    string msg = line.Split(new string[] { "msg:" }, StringSplitOptions.RemoveEmptyEntries)[1];
                    if (users.Count(x => x.UserId == int.Parse(inputs[0])) > 0)
                    {
                        AddMessage(int.Parse(inputs[2]), int.Parse(inputs[3]), msg);
                        List<ConnectedUser> res = GetUsersFromChat(int.Parse(inputs[3]));
                        foreach (var user in res)
                        {
                            Console.WriteLine(user.UserName);
                            var sw = new StreamWriter(user.Client.GetStream());
                            sw.AutoFlush = true;
                            sw.WriteLine("Update^ " + int.Parse(inputs[3]));
                        }
                    }
                }

                if (line.Contains("Disconnect^"))
                {
                    string[] inputs = line.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                    if (users.Count(x => x.UserId == int.Parse(inputs[0])) > 0)
                    {
                        users.RemoveAll(x => x.UserId == int.Parse(inputs[0]));
                        break;
                    }
                }
            }

        }
        users.RemoveAll(x => x.UserId == client.UserId);
        Console.WriteLine("User " + client.UserName + " (" + client.UserId + ") disconnected!");

    });
}




void CreateChat(string Topic, List<int> ids, string message, int sender)
{
    MySqlConnection conn = new MySqlConnection(ConnectionString);
    conn.Open();
    string sql = "insert into chats(Topic) values('" + Topic + "')";
    MySqlCommand command = new MySqlCommand(sql, conn);
    command.ExecuteNonQuery();

    int chatId = -1;
    using (var cmd = new MySqlCommand())
    {
        cmd.CommandText = "SELECT LAST_INSERT_ID() from chats;";
        cmd.Connection = conn;
        MySqlDataReader reader = cmd.ExecuteReader();
        if (reader.Read())
        {
            chatId = Convert.ToInt32(reader.GetValue(0));
        }
        reader.Close();
    }

    foreach (var item in ids)
    {
        sql = "insert into chat_members values(" + chatId.ToString() + "," + item.ToString() + ")";
        command.CommandText = sql;
        command.ExecuteNonQuery();
    }

    conn.Close();

    AddMessage(sender, chatId, message);
    List<ConnectedUser> res = GetUsersFromChat(chatId);
    foreach (var user in res)
    {
        Console.WriteLine(user.UserName);
        var sw = new StreamWriter(user.Client.GetStream());
        sw.AutoFlush = true;
        sw.WriteLine("Update^ " + chatId);
    }
}
void CreateChatFromIDS(string Topic, List<int> ids)
{
    MySqlConnection conn = new MySqlConnection(ConnectionString);
    conn.Open();
    string sql = "insert into chats(Topic) values('" + Topic + "')";
    MySqlCommand command = new MySqlCommand(sql, conn);
    command.ExecuteNonQuery();

    int chatId = -1;
    using (var cmd = new MySqlCommand())
    {
        cmd.CommandText = "SELECT LAST_INSERT_ID() from chats;";
        cmd.Connection = conn;
        MySqlDataReader reader = cmd.ExecuteReader();
        if (reader.Read())
        {
            chatId = Convert.ToInt32(reader.GetValue(0));
        }
        reader.Close();
    }

    foreach (var item in ids)
    {
        sql = "insert into chat_members values(" + chatId.ToString() + "," + item.ToString() + ")";
        command.CommandText = sql;
        command.ExecuteNonQuery();
    }

    conn.Close();
}

void AddMessage(int idUser, int idChat, string text)
{
    MySqlConnection conn = new MySqlConnection(ConnectionString);
    conn.Open();
    string sql = "insert into messages(ID_user,ID_chat,Text) values(" + idUser + "," + idChat + ",'" + text + "')";
    MySqlCommand command = new MySqlCommand(sql, conn);
    command.ExecuteNonQuery();
    conn.Close();
}

List<ConnectedUser> GetUsersFromChat(int chatId)
{
    List<ConnectedUser> urs = new List<ConnectedUser>();
    MySqlConnection conn = new MySqlConnection(ConnectionString);
    conn.Open();
    using (var cmd = new MySqlCommand())
    {
        cmd.CommandText = "SELECT ID_user from chat_members where ID_chat in(" + chatId + ");";
        cmd.Connection = conn;
        MySqlDataReader reader = cmd.ExecuteReader();
        int userId;
        while (reader.Read())
        {
            userId = Convert.ToInt32(reader.GetValue(0));
            ConnectedUser user = users.Find(x => x.UserId == userId);
            if (user != null)
            {
                urs.Add(user);
            }
        }
        reader.Close();
    }
    conn.Close();
    return urs;
}


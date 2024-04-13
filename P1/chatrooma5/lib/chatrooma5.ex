defmodule Chatrooma5 do
  def main() do
    pid = spawn(Chat, :handle, [%{messages: [], users: []}])
    run(pid)
    pid
  end


  def run(channel) do
    IO.puts("--------------------------------------------------")
    IO.puts("Welcome to the chat room manager with Actors!")
    IO.puts("Please enter your command: ")
    IO.puts("1. Join chatroom")
    IO.puts("2. Delete user from chatroom")
    IO.puts("3. Write message")
    IO.puts("4. Read messages")
    IO.puts("--------------------------------------------------")
    command = IO.gets("") |> String.trim()

    case command do
      "1" -> add_user(channel)
      "2" -> user_delete(channel)
      "3" -> write_message(channel)
      "4" -> read_messages(channel)
      _ -> IO.puts("Invalid command")
    end
    run(channel)
  end

  def add_user (channel) do
    IO.puts("Enter your username: ")
    user = IO.gets("") |> String.trim()
    send channel, {:join, user}
  end

  def user_delete (channel) do
    IO.puts("Enter your username: ")
    user = IO.gets("") |> String.trim()
    send channel, {:exit, user}
  end

  def write_message (channel) do
    IO.puts("Enter your username: ")
    user = IO.gets("") |> String.trim()
    IO.puts("Enter your message: ")
    message = IO.gets("") |> String.trim()
    send channel, {:write, user, message}
  end

  def read_messages (channel) do
    IO.puts("Enter your username: ")
    user = IO.gets("") |> String.trim()
    send channel, {:read, user}
  end
end

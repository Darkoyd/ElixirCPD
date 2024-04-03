defmodule Main do
  def start do
    {:ok, pid} = Task.start_link(fn -> MutexChatroom.func(%{users: [], messages: []}) end)
    MutexChatroom.start()
    run(pid)
  end

  def run(pid) do
    IO.puts("--------------------------------------------------")
    IO.puts("Welcome to the chat room manager!")
    IO.puts("Please enter your command: ")
    IO.puts("1. Join chatroom")
    IO.puts("2. Disconnect from chatroom")
    IO.puts("3. Write message")
    IO.puts("4. Read messages")
    IO.puts("--------------------------------------------------")
    command = IO.gets("") |> String.trim()

    case command do
      "1" -> join_chatroom(pid)
      "2" -> disconnect(pid)
      "3" -> write_message(pid)
      "4" -> read_messages(pid)
      _ -> IO.puts("Invalid command")
    end

    Process.sleep(1000)

    run(pid)
  end

  defp join_chatroom(pid) do
    IO.puts("Enter your username: ")
    username = IO.gets("") |> String.trim()
    send(pid, {:join, username})
  end

  defp disconnect(pid) do
    IO.puts("Enter your username: ")
    username = IO.gets("") |> String.trim()
    send(pid, {:disconnect, username})
  end

  defp write_message(pid) do
    IO.puts("Enter your username: ")
    username = IO.gets("") |> String.trim()
    IO.puts("Enter your message: ")
    message = IO.gets("") |> String.trim()
    send(pid, {:write_message, username, message})
  end

  defp read_messages(pid) do
    IO.puts("Enter your username: ")
    username = IO.gets("") |> String.trim()
    send(pid, {:read_messages, username})
  end
end

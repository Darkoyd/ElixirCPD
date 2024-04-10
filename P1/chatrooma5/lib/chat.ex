defmodule Chat do
  def handle(state) do
    receive do
      {:join, user} -> add_user(state, user)
      {:exit, user} -> user_delete(state, user)
      {:write, user, message} -> write_message(state, user, message)
      {:read, user} -> read_messages(state, user)
      _ -> state
    end
  end

  def add_user(state, user) do
    IO.inspect(state)
    IO.inspect(user)
    user_list = state |> Map.get(:users)

    if user_list |> Enum.member?(user) do
      IO.puts("SERVER: User #{user} already exists in the chatroom")
      state
    else
      state = state |> Map.update!(:users, &[user | &1])
      IO.puts("SERVER: User #{user} has joined the chatroom")
      state
    end
  end

  def user_delete(state, user) do

    user_list = state |> Map.get(:users)

    if user_list |> Enum.member?(user) do
      state = state |> Map.update!(:users, &List.delete(&1, user))
      IO.puts("SERVER: User #{user} has left the chatroom")
      state
    else
      IO.puts("SERVER: User #{user} does not exist in the chatroom")
      state
    end
  end

  def write_message(state, user, message) do

    user_list = state |> Map.get(:users)

    if user_list |> Enum.member?(user) do
      state = state |> Map.update!(:messages, &["#{user}: #{message}" | &1])
      IO.puts("SERVER: Message from #{user} has been added to the chatroom")
      state
    else
      IO.puts("SERVER: User #{user} does not exist in the chatroom")
      state
    end
  end

  def read_messages(state, user) do

    user_list = state |> Map.get(:users)

    if user_list |> Enum.member?(user) do
      messages = state |> Map.get(:messages)
      IO.puts("*******************************")
      IO.puts("SERVER: Messages in chatroom:")
      Enum.each(messages, &IO.puts(&1))
      IO.puts("*******************************")
      state
    else
      IO.puts("SERVER: User #{user} does not exist in the chatroom")
      state
    end
  end
end

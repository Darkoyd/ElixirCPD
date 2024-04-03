defmodule MutexChatroom do
  def start do
    children = [
      {Mutex, name: ChatLock}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def func(state) do
    receive do
      {:join, user} ->
        state = join(state, user)
        func(state)

      {:disconnect, user} ->
        state = disconnect(state, user)
        func(state)

      {:write_message, user, message} ->
        state = write_message(state, user, message)
        func(state)

      {:read_messages, user} ->
        state = read_messages(state, user)
        func(state)

      {:exit} ->
        IO.puts("SERVER: Goodbye!")
    end
  end

  def join(state, user) do
    lock = Mutex.await(ChatLock, state)

    user_list = state |> Map.get(:users)

    if user_list |> Enum.member?(user) do
      IO.puts("SERVER: User #{user} already exists in the chatroom")
      Mutex.release(ChatLock, lock)
      state
    else
      state = state |> Map.update!(:users, &[user | &1])
      IO.puts("SERVER: User #{user} has joined the chatroom")
      Mutex.release(ChatLock, lock)
      state
    end
  end

  def disconnect(state, user) do
    lock = Mutex.await(ChatLock, state)

    user_list = state |> Map.get(:users)

    if user_list |> Enum.member?(user) do
      state = state |> Map.update!(:users, &List.delete(&1, user))
      IO.puts("SERVER: User #{user} has left the chatroom")
      Mutex.release(ChatLock, lock)
      state
    else
      IO.puts("SERVER: User #{user} does not exist in the chatroom")
      Mutex.release(ChatLock, lock)
      state
    end
  end

  def write_message(state, user, message) do
    lock = Mutex.await(ChatLock, state)

    user_list = state |> Map.get(:users)

    if user_list |> Enum.member?(user) do
      state = state |> Map.update!(:messages, &["#{user}: #{message}" | &1])
      IO.puts("SERVER: Message from #{user} has been added to the chatroom")
      Mutex.release(ChatLock, lock)
      state
    else
      IO.puts("SERVER: User #{user} does not exist in the chatroom")
      Mutex.release(ChatLock, lock)
      state
    end
  end

  def read_messages(state, user) do
    lock = Mutex.await(ChatLock, state)

    user_list = state |> Map.get(:users)

    if user_list |> Enum.member?(user) do
      messages = state |> Map.get(:messages)
      IO.puts("*******************************")
      IO.puts("SERVER: Messages in chatroom:")
      Enum.each(messages, &IO.puts(&1))
      IO.puts("*******************************")
      Mutex.release(ChatLock, lock)
      state
    else
      IO.puts("SERVER: User #{user} does not exist in the chatroom")
      Mutex.release(ChatLock, lock)
      state
    end
  end
end

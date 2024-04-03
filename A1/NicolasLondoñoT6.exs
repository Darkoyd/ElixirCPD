defmodule TopSecret do
  def to_ast(string) do
    {_, ast} = Code.string_to_quoted(string)
    ast
  end

  def decode_secret_message_part(ast_node, acc) do
    list =
      ast_node
      |> Tuple.to_list()

    case Enum.at(list, 0) do
      :def ->
        arity = list |> Enum.at(2) |> Enum.at(0) |> elem(2) |> length()
        func_name = list |> Enum.at(2) |> Enum.at(0) |> elem(0)

        case func_name do
          :when ->
            new_func_name =
              list
              |> Enum.at(2)
              |> Enum.at(0)
              |> elem(2)
              |> Enum.at(0)
              |> elem(0)
              |> to_string()
              |> String.slice(0, arity)


              _ ->
                new_func_name = func_name |> to_string() |> String.slice(0, arity)
              end

              :defp ->
                arity = list |> Enum.at(2) |> Enum.at(0) |> elem(2) |> length()
                func_name = list |> Enum.at(2) |> Enum.at(0) |> elem(0)

                case func_name do
                  :when ->
            new_func_name =
              list
              |> Enum.at(2)
              |> Enum.at(0)
              |> elem(2)
              |> Enum.at(0)
              |> elem(0)
              |> to_string()
              |> String.slice(0, arity)

            _ ->
              func_name = func_name |> to_string() |> String.slice(0, arity)
              [func_name | acc]
            end

            [func_name | acc]
            _ ->
              acc
            end
          end
        end

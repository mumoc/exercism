defmodule TopSecret do
  def to_ast(string) do
    {:ok, ast} = Code.string_to_quoted(string)
    ast
  end

  def decode_secret_message_part({operation, _, [head | _]} = ast, acc)
      when operation in [:def, :defp] do
    {name, _, args} =
      case head do
        {:when, _, [function | _]} -> function
        function -> function
      end
  
    decode_function(ast, acc, name, args)
  end
    
  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end
  
  defp decode_function(ast, acc, name, args) do
    arity = if args == nil, do: 0, else: length(args)
  
    message_part =
      name
      |> Atom.to_string()
      |> String.slice(0, arity)
  
    {ast, [message_part | acc]}
  end
  
  def decode_secret_message(code) do
    code
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
  end
end

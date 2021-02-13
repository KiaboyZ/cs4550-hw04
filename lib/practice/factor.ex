defmodule Practice.Factor do
  
  defp parse_int(text) do
    cond do
      is_integer(text) -> text
      true ->
        {num, _} = Integer.parse(text)
        num
      end
  end
  
  defp get_factors(number) do
    cond do
      4 > number -> [number]
      rem(number, 2) == 0 -> [2] ++ get_factors(div(number, 2))
      true -> get_factors(number, 3)
    end
  end

  defp get_factors(number, fact) do
    cond do
      (fact * 2) > number -> [number]
      rem(number, fact) == 0 -> [fact] ++ get_factors(div(number, fact))
      true -> get_factors(number, fact + 2)
    end
  end

  # input should be an integer
  def factor(x) do
    cond do
      is_integer(x) -> get_factors(parse_int(x))
      true -> Enum.map(get_factors(parse_int(x)), fn(x) -> to_string(x) <> " " end)
    end
  end
end

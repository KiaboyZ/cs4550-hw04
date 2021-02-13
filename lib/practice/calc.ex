defmodule Practice.Calc do
  defp parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end
  
  defp md_eval(expr, acc) do
    try do
      case hd(expr) do
        "*" ->
          a = List.last(acc) * hd(tl(expr))
          md_eval(tl(tl(expr)), List.replace_at(acc, length(acc)-1, a))
        "/" ->
          a = List.last(acc) / hd(tl(expr))
          List.delete_at(acc, length(acc)-1)
          md_eval(tl(tl(expr)), List.replace_at(acc, length(acc)-1, a))
        _ ->
          md_eval(tl(expr), acc ++ [hd(expr)])
      end
    rescue
      _ ->
        acc
    end
  end

  defp pm_eval(expr, acc) do
    try do
      case hd(expr) do
        "+" ->
          a = List.last(acc) + hd(tl(expr))
          pm_eval(tl(tl(expr)), List.replace_at(acc, length(acc)-1, a))
        "-" ->
          a = List.last(acc) - hd(tl(expr))
          pm_eval(tl(tl(expr)), List.replace_at(acc, length(acc)-1, a))
        _ ->
          pm_eval(tl(expr), acc ++ [hd(expr)])
      end
    rescue
      _ -> hd(acc)
    end
  end

  defp evaluate(expr) do
    expr1 = md_eval(expr, [])
    result = pm_eval(expr1, [])
    result
  end


  # Expression must have spaces between numbers and operator
  def calc(expr) do
    expr
    |> String.split(~r{\s}, trim: true)
    |> Enum.map(fn(x) -> if Float.parse(x) == :error
                          do x
                        else
                          parse_float(x)
                        end end)
    |> evaluate()

  end
end

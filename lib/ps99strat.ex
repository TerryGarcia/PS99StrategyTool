defmodule Ps99strat do
  @moduledoc """
  Ps99strat keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  # 3,420,000 -> 3.42M
  # 3,920 -> 3.92k
  # 920 -> 920
  # 2.85714 -> 2.86
  def pretty_print(number) do
    {mant, exp} = break_down(number)
    pretty_print(number, mant, exp) |> IO.iodata_to_binary()
  end

  defp pretty_print(_, mant, 12), do: :io_lib.format("~.2fq", [mant])
  defp pretty_print(_, mant, 9), do: :io_lib.format("~.2ft", [mant])
  defp pretty_print(_, mant, 6), do: :io_lib.format("~.2fM", [mant])
  defp pretty_print(_, mant, 3), do: :io_lib.format("~.2fk", [mant])
  defp pretty_print(num, _, _), do: :io_lib.format("~.2f", [num / 1.0])

  defp break_down(number) do
    mag = :math.ceil(Math.log10(number)) - 1
    exp = :math.floor(mag / 3) * 3
    {number / Math.pow(10, exp), trunc(exp)}
  end
end

defmodule Prim do
  def tal(n) do
    list = Enum.to_list(2..n)
    IO.inspect(forstalosningen(list))
  end

  def forstalosningen([h|t]) do
    forstalosningen(t, [h])
  end
  def kolladelbarhet(_, []) do true end
  def kolladelbarhet(nr, [h|t]) do
    cond do
      rem(nr, h) == 0 ->
        false
      true ->
        kolladelbarhet(nr, t)
    end

  end

  def forstalosningen([], tal) do tal end
  def forstalosningen([h|t], tal) do
    case kolladelbarhet(h, tal) do
      true ->
        forstalosningen(t, [h|tal])
      false ->
        forstalosningen(t, tal)
    end
  end
end

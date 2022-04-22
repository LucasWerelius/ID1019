defmodule Prim do
  def tal(n) do
    IO.write("Forsta: ")
    #IO.inspect(forstalosningen(Enum.to_list(2..n)))
    IO.inspect(:timer.tc(fn -> forstalosningen(n) end, []))
    IO.write("Andra:  ")
    #IO.inspect(andralosningen(Enum.to_list(2..n)))
    IO.inspect(:timer.tc(fn -> andralosningen(n) end, []))
    IO.write("Tredje: ")
    #IO.inspect(tredjelosningen(Enum.to_list(2..n)))
    IO.inspect(:timer.tc(fn -> tredjelosningen(n) end, []))
    :ok
  end

  def forstalosningen(p) do
    forstalosningen(Enum.to_list(2..p), [])
  end

  def tabortomdelbar([], _) do [] end
  def tabortomdelbar([h|t], x) do
    case rem(h, x) == 0 do
      false ->
        [h|tabortomdelbar(t, x)]
      true ->
        tabortomdelbar(t, x)
    end
  end

  def forstalosningen([], primtal) do primtal end
  def forstalosningen([h|t], primtal) do
    forstalosningen(tabortomdelbar(t, h), primtal ++ [h])
  end

  def andralosningen(p) do
    andralosningen(Enum.to_list(2..p), [])
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

  def andralosningen([], primtal) do primtal end
  def andralosningen([h|t], primtal) do
    case kolladelbarhet(h, primtal) do
      true ->
        andralosningen(t, primtal ++ [h])
      false ->
        andralosningen(t, primtal)
    end
  end


  def tredjelosningen(p) do
    tredjelosningen(Enum.to_list(2..p), [])
  end

  def tredjelosningen([], tal) do reverse(tal, []) end
  def tredjelosningen([h|t], tal) do
    case kolladelbarhet(h, tal) do
      true ->
        tredjelosningen(t, [h|tal])
      false ->
        tredjelosningen(t, tal)
    end
  end

  def reverse([], ny) do
    ny
  end
  def reverse([h|t], ny) do
    reverse(t, [h|ny])
  end
end

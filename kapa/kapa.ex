defmodule Lumber do
  def bench(n) do
    for i <- 1..n do
    {t,_} = :timer.tc(fn() -> cost(Enum.to_list(1..i)) end)
    IO.puts(" n = #{i}\t t = #{t} us")
    end
  end

  def split(seq) do split(seq, 0, [], []) end
  def split([], l, left, right) do
  [{left, right, l}]
  end
  def split([s|rest], l, left, right) do
  split(rest, l+s, [s|left], right) ++ split(rest, l+s, left, [s|right])
  end

  def cost([], l, left, right, mem) do
    {costleft, cutleft, mem} = check(left, mem)
    {costright, cutright, mem} = check(right, mem)
    {costleft + costright + l, {cutleft, cutright}, mem}
  end
  def cost([s], l, [], right, mem) do
    {costright, cutright, mem} = check(right, mem)
    {s + costright + l, {s, cutright}, mem}
  end
  def cost([s], l, left, [], mem) do
    {costleft, cutleft, mem} = check(left, mem)
    {s + costleft + l, {s, cutleft}, mem}
  end

  def cost([s|rest], l, left, right, mem) do
    {cost1, cut, mem} = cost(rest, l+s, [s|left], right, mem)
    {cost2, cut2, mem} = cost(rest, l+s, left, [s|right], mem)
    if cost1 < cost2 do
      {cost1, cut, mem}
    else
      {cost2, cut2, mem}
    end
  end

  def cost([]) do {0, :na} end
  def cost(seq) do
    {cost, tree, _} = cost(Enum.sort(seq), Memo.new())
    {cost, tree}
  end

  def cost([s], mem) do {0, s, mem}end
  def cost([s|rest]=seq, mem) do
    {c, t, mem} = cost(rest, s, [s], [], mem)
    {c, t, Memo.add(mem, seq, {c, t})}
  end


  def check(seq, mem) do
    case Memo.lookup(mem, seq) do
      nil ->
        cost(seq, mem)
      {c, t} ->
        {c, t, mem}
    end
  end
end

defmodule Memo do
  def new() do %{} end
  def add(mem, key, val) do
    Map.put(mem, :binary.list_to_bin(key), val)
  end
  def lookup(mem, key) do
    Map.get(mem, :binary.list_to_bin(key))
  end
end

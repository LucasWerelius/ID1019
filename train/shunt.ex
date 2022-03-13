defmodule Shunt do
  def find([], _) do [] end
  def find([h|xs], [h2|ys]) do
    {hs, ts} = split([h|xs], h2)
    {[_|next], [], []} = Enum.at(Moves.move([{:one, length(ts) + 1}, {:two, length(hs)}, {:one, -(length(ts) + 1)}, {:two, -length(hs)}], {[h|xs], [], []}), 4)
    Lists.append([{:one, length(ts) + 1}, {:two, length(hs)}, {:one, -(length(ts) + 1)}, {:two, -length(hs)}], find(next, ys))
  end

  def few([], _) do [] end
  def few([h|xs], [h|ys]) do few(xs, ys) end
  def few([h|xs], [h2|ys]) do
    {hs, ts} = split([h|xs], h2)
    {[_|next], [], []} = Enum.at(Moves.move([{:one, length(ts) + 1}, {:two, length(hs)}, {:one, -(length(ts) + 1)}, {:two, -length(hs)}], {[h|xs], [], []}), 4)
    Lists.append([{:one, length(ts) + 1}, {:two, length(hs)}, {:one, -(length(ts) + 1)}, {:two, -length(hs)}], few(next, ys))
  end

  def split(list, var) do
    pos = Lists.position(list, var)
    {Lists.take(list, pos-1), Lists.drop(list, pos)}
  end
end

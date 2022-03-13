defmodule Lists do
  def take(_, 0) do [] end
  def take([h|t], n) do
    [h|take(t, n-1)]
  end

  def drop(list, 0) do list end
  def drop([_|t], n) do
    drop(t, n-1)
  end

  def append(list, []) do list end
  def append([], list) do list end
  def append([h|t], ys) do
    [h|append(t, ys)]
  end

  def member([], _) do false end
  def member([y|_], y) do true end
  def member([_|t], y) do
    member(t, y)
  end

  def position(xs, y) do
    position(xs, y, 1)
  end
  def position([y|_], y, x) do x end
  def position([_|t], y, x) do
    position(t, y, x+1)
  end
end

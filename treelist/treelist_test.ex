defmodule Bench do
  def bench() do

    ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

    time = fn (i, f) ->
      seq = Enum.map(1..i, fn(_) -> :rand.uniform(100000) end)
      elem(:timer.tc(fn () -> f.(seq) end),0)
    end

    bench = fn (i) ->
      list = fn (seq) ->
        List.foldr(seq, list_new(), fn (e, acc) -> list_insert(e, acc) end)
      end

      tree = fn (seq) ->
        List.foldr(seq, tree_new(), fn (e, acc) -> tree_insert(e, acc) end)
      end

      tl = time.(i, list)
      tt = time.(i, tree)

      IO.write("  #{tl}\t\t\t#{tt}\n")
    end

    IO.write("# benchmark of lists and tree \n")
    Enum.map(ls, bench)


    :ok
  end

  def test() do
    list = list_new()
    list = list_insert(16, list)
    list = list_insert(10, list)
    list = list_insert(93, list)
    list = list_insert(94, list)
    list = list_insert(69, list)
    IO.inspect(list)

    IO.write("\n\n")

    list = tree_new()
    list = tree_insert(16, list)
    list = tree_insert(10, list)
    list = tree_insert(93, list)
    list = tree_insert(94, list)
    list = tree_insert(69, list)
    IO.write(inspect(list))
  end
  def list_new() do [] end
  def list_insert(e, [h | t]) do
  case (e > h) do
  true -> [h | list_insert(e, t)]
  false -> [e] ++ [h | t]
  end
  end
  def list_insert(e, []) do [e] end

  def tree_new() do {} end
  def tree_insert(e, {h, l, r}) do
  case (e > h) do
  true -> {h, l, tree_insert(e, r)}
  false -> {h, tree_insert(e, l), r}
  end
  end
  def tree_insert(e, _) do {e, :nil, :nil} end
end

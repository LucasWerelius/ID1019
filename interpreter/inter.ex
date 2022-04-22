defmodule Env do
  def new() do [] end

  def add(id, str, env) do
    [{id, str}|env]
  end

  def lookup(_, []) do nil end
  def lookup(id, [{id, str}|_]) do
    {id, str}
  end
  def lookup(id, [_|t]) do
    lookup(id, t)
  end

  def remove([], env) do env end
  def remove([h|t], env) do
    remove(t, remove(h, env, []))
  end

  def remove(_, [], new) do new end
  def remove(id, [{id, _}|t], new) do
    remove(id, t, new)
  end
  def remove(id, [h|t], new) do
    remove(id, t, [h|new])
  end
end

defmodule Eager do
  def eval_expr({:atm, id}, []) do {:ok, id} end
  def eval_expr({:var, id}, env) do
    case env do
      nil ->
        :error
      {_, str} ->
        {:ok, str}
    end
  end

  #def eval_expr({:cons, a, b}, env) do
  #  case eval_expr(..., ...) do
  #    :error ->
   #     ...
    #  {:ok, ...} ->
     # case eval_expr(..., ...) do
      #  :error ->
       #   ...
        #{:ok, ts} ->
        #...
      #end
    #end
  #end
end

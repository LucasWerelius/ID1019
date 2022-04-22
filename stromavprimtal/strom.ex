defmodule Primes do
  defstruct [:next]
  def primes() do
    %Primes{next: fn() -> {2, fn() -> sieve(z(3), 2) end} end}
  end

  def z() do
    fn() -> z(0) end
  end
  def z(n) do
    fn() -> {n, z(n+1)} end
  end

  def filter(func, nbr) do
    {n, func2} = func.()
    case rem(n, nbr) do
      0 ->
        filter(func2, nbr)
      _ ->
        {n, fn -> filter(func2, nbr) end}
    end
  end

  def sieve(func, p) do
    {n, func2} = filter(func, p)
    {n, fn() -> sieve(func2, n) end}
  end

  def gamlaprimes() do
    fn() -> {2, fn() -> sieve(z(3), 2) end} end
  end

  def next(%Primes{next: x}) do
    {n, func2} = x.()
    {n, %Primes{next: func2}}
  end

defimpl Enumerable do
  def count(_) do {:error, __MODULE__} end
  def member?(_, _) do {:error, __MODULE__} end
  def slice(_) do {:error, __MODULE__} end
  def reduce(_, {:halt, acc}, _fun) do
    {:halted, acc}
  end
  def reduce(primes, {:suspend, acc}, fun) do
    {:suspended, acc, fn(cmd) -> reduce(primes, cmd, fun) end}
  end
  def reduce(primes, {:cont, acc}, fun) do
    {p, next} = Primes.next(primes)
    reduce(next, fun.(p,acc), fun)
  end
end
end

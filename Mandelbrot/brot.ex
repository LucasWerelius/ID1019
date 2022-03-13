defmodule Brot do
  def mandelbrot(c, m) do
    z0 = Cmplx.new(0, 0)
    i = 0
    test(i, z0, c, m)
  end

  def test(m, _, _, m) do 0 end
  def test(i, z, c, m) do
    {:re, x, :im, 0} = Cmplx.abs(z)
    case x < 2 do
      true ->
        test(i+1, Cmplx.add(Cmplx.sqr(z), c), c, m)
      false ->
        i
    end
  end
end

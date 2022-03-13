defmodule Cmplx do
  def new(r,i) do
    {:re, r, :im, i}
  end

  def add({:re, r, :im, i}, {:re, r2, :im, i2}) do
    {:re, r + r2, :im, i + i2}
  end

  def sqr({:re, r, :im, i}) do
    {:re, r*r - i*i, :im, 2*r*i}
  end

  def abs({:re, r, :im, i}) do
    {:re, :math.sqrt(r*r+i*i), :im, 0}
  end
end

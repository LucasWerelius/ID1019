defmodule Der do
#def derivative(n) when is_number(n) do: ...
#end
#def derivative(n) when is_atom(n) do: ...
#end
def testall() do
  test()
  IO.write("\n")
  test2()
  IO.write("\n")
  test3()
  IO.write("\n")
  test4()
  IO.write("\n")
  test5()
  IO.write("\n")
  test6()
  IO.write("\n")
  test7()
end

def test() do
  f= {:add, {:mul, {:num, 2}, {:var, :x}}, {:num, 3}}
  d= deriv(f, :x)
  IO.write("Function: #{print(f)}\n")
  IO.write("Derivate: #{print(d)}\n")
  IO.write("Simplified: #{print(simplify(d))}\n")
end


def test2() do
  f= {:exp, {:var, :x}, {:num, 3}}
  d= deriv(f, :x)
  c = calc(d, :x, 5)
  IO.write("Function: #{print(f)}\n")
  IO.write("Derivate: #{print(d)}\n")
  IO.write("Simplified: #{print(simplify(d))}\n")
  IO.write("Calculated with x=5: #{print(simplify(c))}\n")
end

def test3() do
  f= {:ln, {:mul, {:num, 2}, {:var, :x}}}
  d= deriv(f, :x)
  c = calc(d, :x, 5)
  IO.write("Function: #{print(f)}\n")
  IO.write("Derivate: #{print(d)}\n")
  IO.write("Simplified: #{print(simplify(d))}\n")
  IO.write("Calculated with x=5: #{print(simplify(c))}\n")
end

def test4() do
  f= {:div, {:num, 2}, {:var, :x}}
  d= deriv(f, :x)
  c = calc(d, :x, 1)
  IO.write("Function: #{print(f)}\n")
  IO.write("Derivate: #{print(d)}\n")
  IO.write("Simplified: #{print(simplify(d))}\n")
  IO.write("Calculated with x=1: #{print(simplify(c))}\n")
end

def test5() do
  f= {:exp, {:var, :x}, {:num, 0.5}}
  d= deriv(f, :x)
  c = calc(d, :x, 25)
  IO.write("Function: #{print(f)}\n")
  IO.write("Derivate: #{print(d)}\n")
  IO.write("Simplified: #{print(simplify(d))}\n")
  IO.write("Calculated with x=25: #{print(simplify(c))}\n")
end

def test6() do
  f= {:sin, {:mul, {:num, 2}, {:var, :x}}}
  d= deriv(f, :x)
  c = calc(d, :x, 0)
  IO.write("Function: #{print(f)}\n")
  IO.write("Derivate: #{print(d)}\n")
  IO.write("Simplified: #{print(simplify(d))}\n")
  IO.write("Calculated with x=0: #{print(simplify(c))}\n")
end

def test7() do
  f= {:exp, {:var, :y}, {:num, 3}}
  d= deriv(f, :x)
  c = calc(d, :x, 0)
  IO.write("Function: #{print(f)}\n")
  IO.write("Derivate: #{print(d)}\n")
  IO.write("Simplified: #{print(simplify(d))}\n")
  IO.write("Calculated with x=0: #{print(simplify(c))}\n")
end

@type literal() :: {:num, number()}
                 | {:var, atom()}

@type expr() :: {:add, expr(), expr()}
              | {:mul, expr(), expr()}
              | {:div, expr(), expr()}
              | {:exp, expr(), literal()}
              | {:ln, expr()}
              | {:sin, expr()}
              | {:cos, expr()}
              | literal()

def deriv({:num, _}, _) do {:num, 0} end
def deriv({:var, v}, v) do {:num, 1} end
def deriv({:var, _}, _) do {:num, 0} end
def deriv({:add, e1, e2}, v) do
  {:add, deriv(e1, v), deriv(e2, v)}
end
def deriv({:mul, e1, e2}, v) do
  {:add,
    {:mul, deriv(e1, v), e2},
    {:mul, e1, deriv(e2, v)}}
end
def deriv({:div, e1, e2}, v) do
  {:div,
    {:add,
      {:mul, deriv(e1, v), e2},
      {:mul, {:num, -1}, {:mul, e1, deriv(e2, v)}}},
    {:exp, e2, {:num, 2}}}
end
def deriv({:exp, e, {:num, n}}, v) do
  {:mul,
      {:mul, {:num, n}, {:exp, e, {:num, n - 1}}},
      deriv(e, v)}
end
def deriv({:ln, e}, v) do
  {:div, deriv(e, v), e}
end
def deriv({:sin, e}, v) do
  {:mul, {:cos, e}, deriv(e, v)}
end

def calc({:num, n}, _, _) do {:num, n} end
def calc({:var, v}, v, n) do {:num, n} end
def calc({:var, v}, _, _) do {:var, v} end
def calc({:add, e1, e2}, v, n) do
  {:add, calc(e1, v, n), calc(e2, v, n)}
end
def calc({:mul, e1, e2}, v, n) do
  {:mul, calc(e1, v, n), calc(e2, v, n)}
end
def calc({:exp, e1, e2}, v, n) do
  {:exp, calc(e1, v, n), calc(e2, v, n)}
end
def calc({:div, e1, e2}, v, n) do
  {:div, calc(e1, v, n), calc(e2, v, n)}
end
def calc({:cos, e}, v, n) do
  {:cos, calc(e, v, n)}
end

def simplify({:add, e1, e2}) do
  simplify_add(simplify(e1), simplify(e2))
end
def simplify({:mul, e1, e2}) do
  simplify_mul(simplify(e1), simplify(e2))
end
def simplify({:div, e1, e2}) do
  simplify_div(simplify(e1), simplify(e2))
end
def simplify({:exp, e1, e2}) do
  simplify_exp(simplify(e1), simplify(e2))
end
def simplify({:sin, e}) do
  {:sin, simplify(e)}
end
def simplify({:cos, e}) do
  {:cos, simplify(e)}
end
def simplify(e) do e end

def simplify_add(e1, {:num, 0}) do e1 end
def simplify_add({:num, 0}, e2) do e2 end
def simplify_add({:num, n1}, {:num, n2}) do {:num, n1 + n2} end
def simplify_add(e1, e2) do {:add, e1, e2} end

def simplify_mul(_, {:num, 0}) do {:num, 0} end
def simplify_mul({:num, 0}, _) do {:num, 0} end
def simplify_mul(e1, {:num, 1}) do e1 end
def simplify_mul({:num, 1}, e2) do e2 end
def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1 * n2} end
def simplify_mul(e1, e2) do {:mul, e1, e2} end


def simplify_div({:num, 0}, _) do {:num, 0} end
def simplify_div(e1, {:num, 1}) do e1 end
def simplify_div({:num, n1}, {:num, n2}) do {:num, n1/n2} end
def simplify_div({:mul, {:num, n1}, {:var, n}}, {:num, n2}) do
  simplify({:mul, {:num, div(n1,n2)}, {:var, n}})
end
def simplify_div({:num, n1}, {:mul, {:num, n2}, {:var, n}}) do
  simplify({:div, {:num, div(n1,n2)}, {:var, n}})
end

def simplify_div(e1, e2) do {:div, e1, e2} end

def simplify_exp(_, {:num, 0}) do {:num, 1} end
def simplify_exp(e1, {:num, 1}) do e1 end
def simplify_exp({:num, n1}, {:num, n2}) do {:num, :math.pow(n1, n2)} end
def simplify_exp(e1, e2) do {:exp, e1, e2} end


def print({:num, n}) do "#{n}" end
def print({:var, n}) do "#{n}" end
def print({:add, e1, e2}) do "(#{print(e1)} + #{print(e2)})" end
def print({:mul, e1, e2}) do "#{print(e1)} * #{print(e2)}" end
def print({:div, e1, e2}) do "(#{print(e1)}) / (#{print(e2)})" end
def print({:exp, e1, e2}) do "(#{print(e1)})^(#{print(e2)})" end
def print({:ln, e1}) do "ln(#{print(e1)})" end
def print({:sin, e1}) do "sin(#{print(e1)})" end
def print({:cos, e1}) do "cos(#{print(e1)})" end

end

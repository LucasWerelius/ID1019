defmodule Moves do
  def single({track, x}, {zero, one, two}) do
    case track do
      :one ->
        case x > 0 do
          true ->
            {Lists.take(zero, length(zero)-x), Lists.append(Lists.drop(zero, length(zero)-x), one), two}
          false ->
            {Lists.append(zero, Lists.take(one, -x)), Lists.drop(one, -x), two}
        end
      :two ->
        case x > 0 do
          true ->
            {Lists.take(zero, length(zero)-x), one, Lists.append(Lists.drop(zero, length(zero)-x), two)}
          false ->
            {Lists.append(zero, Lists.take(two, -x)), one, Lists.drop(two, -x)}
        end
    end
  end

  def move(moves, state) do
    move(moves, state, [state])
  end

  def move([], _, print) do print end
  def move([h|t], state, print) do
    next = single(h, state)
    move(t, next, Lists.append(print,[next]))
  end
end

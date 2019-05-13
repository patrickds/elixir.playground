# Run with $ elixirc modules.ex

defmodule Math do
  def sum(a, b) do
    do_sum(a, b)
  end

  defp do_sum(a, b) do
    a + b
  end
end

# IO.puts Math.sum(1, 2)    # => 3
# IO.puts Math.do_sum(1, 2) # => ** (UndefinedFunctionError)defmodule Math do

defmodule Math do
  def zero?(0) do
    true
  end

  def zero?(x) when is_integer(x) do
    false
  end
end

# IO.puts Math.zero?(0)         #=> true
# IO.puts Math.zero?(1)         #=> false
# IO.puts Math.zero?([1, 2, 3]) #=> ** (FunctionClauseError)
# IO.puts Math.zero?(0.0)       #=> ** (FunctionClauseError)

defmodule Math do
  def zero?(0), do: true
  def zero?(x) when is_integer(x), do: false
end

# Function Capturing and Lambdas

Math.zero?(0) # => true
fun = &Math.zero?/1  # => &Math.zero?/1
fun.(0)  # => true

fun2 = &(&1 + 2) # => #Function<6.128620087/1 in :erl_eval.expr/5>
fun2.(1) # => 3

fun3 = &"Good #{&1}"  # => #Function<6.128620087/1 in :erl_eval.expr/5>
fun3.("morning")  # => "Good morning"

# Default Values

defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

# IO.puts Concat.join("Hello", "world")      #=> Hello world
# IO.puts Concat.join("Hello", "world", "_") #=> Hello_world

defmodule Concat do
  def join(a, b \\ nil, sep \\ " ")

  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world")      #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world
IO.puts Concat.join("Hello")               #=> Hello

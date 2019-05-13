# Functions
add = fn a, b -> a + b end

# elixir makes clear distinction between anonyomous and named functions by putting a dot before the parenthesis
IO.puts(add.(1, 2))

# (Linked) Lists
list = [1, 2, true, 3]
lenghtOfAList = length([1, 2, 3]) # => 3
concatLists = [1, 2, 3] ++ [4, 5, 6] # => [1, 2, 3, 4, 5, 6]
subtractLists = [1, true, 2, false, 3, true] -- [true, false] # => [1, 2, 3, true]
headOfList = hd([1, 2, 3]) # => 1
tailOfList = tl([1, 3, 3]) # => [3, 3]
# Note that hd [] => Error

# String
"foo" <> "bar"  # => "foobar"

## Equality
# == false
'hello' == "hello"

# Gather info/help
# i 'hello'
# h is_boolean/1

# Anonymous funcs
add = fn a, b -> a + b end
add.(1, 2)
double = fn a -> add.(a, a) end
double.(2)

# Tuples
tuple = {:ok, "hello"}  # => {:ok, "hello"}
tuple_size {:ok, "hello"}  # => 2
elem(tuple, 1)  # => "hello"
put_elem(tuple, 1, "world")  # => {:ok, "world"}

# Pattern Matching

{a, b, c} = {:hello, "world", 42}
a  # => :hello
b  # => "world"
c  # => 42

# it matches symbols nicely yey
{:ok, result} = {:ok, 13}  # => {:ok, 13}
result  # => 13

{:ok, result} = {:error, :oops}  # => %MatchError{term: {:error, :oops}}

[a, b, c] = [1, 2, 3]  # => [1, 2, 3]
a  # => 1

[head | tail] = [1, 2, 3]  # => [1, 2, 3]
head  # => 1
tail # => [2, 3]

list = [1, 2, 3]  # => [1, 2, 3]
[0 | list] # => [0, 1, 2, 3]


# case, cond, and if

case {1, 2, 3} do
  {4, 5, 6} -> "This clause won't match"
  {1, x, 3} -> "This clause will match and bind x to 2 in this clause"
  _ -> "This clause would match any value"
end
# => "This clause will match and bind x to 2 in this clause"

case {1, 2, 3} do
  {1, x, 3} when x > 0 -> "Will match"
  _ -> "Would match, if guard condition were not satisfied"
end
# => "Will match"

case :ok do
  :error -> "Won't match"
end
# => ** (CaseClauseError) no case clause matching: :ok

f = fn
  x, y when x > 0 -> x + y
  x, y -> x * y
end

f.(1, 3) # => 4
f.(-1, 3) # => -3

cond do
  2 + 2 == 5 -> "This will not be true"
  2 * 2 == 3 -> "Nor this"
  1 + 1 == 2 -> "But this will"
  true -> "This is always true (equivalent to else)"
end
# => "But this will"

cond do
  hd([1, 2, 3]) -> "1 is considered as true"
end
# => "1 is considered as true"

if true do
  "This works!"
else
  "This will never be seen"
end

unless true do
  "This will never be seen"
end

if true do
  "This works!"
end

if true, do: 1 + 2

# These are equivalent

if false, do: :this, else: :that
if(false, [do: :this, else: :that])

if true do
  a = 1 + 2
  a + 10
end
# => 13

if true, do: (
  a = 1 + 2
  a + 10
)
# => 13

# Keyword lists
list = [{:a, 1}, {:b, 2}] # => [a: 1, b: 2]
list == [a: 1, b: 2] # => true
list[:a]  # => 1

# Maps
map = %{:a => 1, 2 => :b}  # => %{2 => :b, :a => 1}
map[:a]  # => 1
map[2]  # => :b
map[:c]  # => nil

%{} = %{:a => 1, 2 => :b}  # => %{2 => :b, :a => 1}
%{:a => a} = %{:a => 1, 2 => :b}  # => %{2 => :b, :a => 1}
a  # => 1
%{:c => c} = %{:a => 1, 2 => :b} # => ** (MatchError) no match of right hand side value: %{2 => :b, :a => 1}

n = 1  # => 1
map = %{n => :one}  # => %{1 => :one}
map[n]  # => :one
%{^n => :one} = %{1 => :one, 2 => :two, 3 => :three}  # => %{1 => :one, 2 => :two, 3 => :three}

Map.get(%{:a => 1, 2 => :b}, :a)  # => 1
Map.put(%{:a => 1, 2 => :b}, :c, 3)  # => %{2 => :b, :a => 1, :c => 3}
Map.to_list(%{:a => 1, 2 => :b})  # => [{2, :b}, {:a, 1}]

map = %{:a => 1, 2 => :b}  # => %{2 => :b, :a => 1}
%{map | 2 => "two"}  # => %{2 => "two", :a => 1}
%{map | :c => 3}  # => %KeyError{key: :c, message: nil, term: %{2 => :b, :a => 1}}

# keyword syntax
map = %{a: 1, b: 2}  # => %{a: 1, b: 2}
map = %{:a => 1, :b => 2}  # => %{a: 1, b: 2}
map.a  # => 1
map.c  # => %KeyError{key: :c, message: nil, term: %{a: 1, b: 2}}

# Nested Structures

users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]
users[:john].age  # => 27

put_in users[:john].age, 31
# => [
# =>   john: %{age: 31, languages: ["Erlang", "Ruby", "Elixir"], name: "John"},
# =>   mary: %{age: 29, languages: ["Elixir", "F#", "Clojure"], name: "Mary"}
# => ]

update_in users[:mary].languages, fn languages -> List.delete(languages, "Clojure") end
# => [
# =>   john: %{age: 27, languages: ["Erlang", "Ruby", "Elixir"], name: "John"},
# =>   mary: %{age: 29, languages: ["Elixir", "F#"], name: "Mary"}
# => ]




# General `reduce_while` ![Build](https://github.com/dominicletz/while/actions/workflows/test.yml/badge.svg)

The module implements a general `reduce_while(acc, fun)` similiar to the `Enum.reduce_while()` but without an Enum. This often can save you from implementing a recursive function. 

```
  import While
  
  i = reduce_while(1, fn i ->
    if i < 10 do
      {:cont, i + 1}
    else
      {:halt, i}
    end
  end)
```

## While Loop Macro Syntax Sugar

Elixir while macro that passes state:

```
while (<varname>,) <expression> do
  <loop>
end
```

Example:

```elixir
import While

cnt = 1
cnt = while cnt, cnt < 10 do
  cnt + 1
end

IO.puts("Current value is #{cnt}")
```

And without state parameter:

```elixir
import While

ref = :counters.new(1, [:atomics])
while :counters.get(ref, 1) < 10 do
  :counters.add(ref, 1, 1)
end

IO.puts("Current value is #{:counters.get(ref, 1)}")
```

Please checkout the full documentation at: https://hexdocs.pm/while/While.html

## Installation

While can be installed by adding `while` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:while, "~> 0.2.4"}
  ]
end
```

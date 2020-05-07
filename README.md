# While Loop

Simple while loop:

```elixir
import While

def demo_global() do
  cnt = :counters.new(1, [:atomics])
  while :counters.get(cnt, 1) < 10 do
    :counters.add(cnt, 1, 1)
  end

  IO.puts("Current value is #{:counters.get(cnt, 1)}")
end

def demo_local() do
  cnt = 1
  cnt = while cnt, cnt < 10 do
    cnt + 1
  end

  IO.puts("Current value is #{cnt}")
end
```

Please checkout the full documentation at: https://hexdocs.pm/while/While.html

## Installation

While can be installed by adding `while` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:while, "~> 0.1.0"}
  ]
end
```

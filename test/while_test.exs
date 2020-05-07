defmodule WhileTest do
  use ExUnit.Case, async: false
  import While

  test "demo_global()" do
    cnt = :counters.new(1, [:atomics])

    while :counters.get(cnt, 1) < 10 do
      :counters.add(cnt, 1, 1)
    end

    IO.puts("Current value is #{:counters.get(cnt, 1)}")
    assert :counters.get(cnt, 1) == 10
  end

  test "demo_local()" do
    cnt = 1

    while_with cnt, cnt < 10 do
      cnt + 1
    end

    IO.puts("Current value is #{cnt}")
    assert cnt == 10
  end
end

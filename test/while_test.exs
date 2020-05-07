defmodule WhileTest do
  use ExUnit.Case, async: false
  import While

  test "while/2" do
    cnt = :counters.new(1, [:atomics])

    while :counters.get(cnt, 1) < 10 do
      :counters.add(cnt, 1, 1)
    end

    IO.puts("Current value is #{:counters.get(cnt, 1)}")
    assert :counters.get(cnt, 1) == 10
  end

  test "while_with" do
    cnt = 1

    while_with cnt, cnt < 10 do
      cnt + 1
    end

    IO.puts("Current value is #{cnt}")
    assert cnt == 10
  end

  test "while/3" do
    cnt = 1

    cnt =
      while cnt, cnt < 10 do
        cnt + 1
      end

    IO.puts("Current value is #{cnt}")
    assert cnt == 10
  end

  test "with tuple" do
    i = 1
    j = 1

    while_with {i, j}, i < 10 do
      {i + 1, j + 1}
    end

    IO.puts("Current values are i: #{i}, j: #{j}")
    assert i == 10
    assert j == 10
  end

  test "reduce_while" do
    i = 1

    i =
      reduce_while(i, fn i ->
        if i < 10 do
          {:continue, i + 1}
        else
          {:halt, i}
        end
      end)

    IO.puts("Current values are i: #{i}")
    assert i == 10
  end

  # Ruby code converted:
  # p = [1.01, 1.02, 1.04]
  # i= 1.01
  # while p.any? {|x| i == x } do
  #      i += 0.01
  #     puts i
  # end

  # sh-4.3$ ruby main.rb
  # 1.02
  # 1.03
  test "ruby example" do
    p = [1.01, 1.02, 1.04]
    i = 1.01

    while_with i, Enum.any?(p, &(i == &1)) do
      IO.puts(i)
      i + 0.01
    end

    assert i == 1.03
  end
end

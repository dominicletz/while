defmodule While do
  @moduledoc """
    While module implements a simple while macro. Use it in your code as follow

    ```
      import While

      def demo_global() do
        cnt = :counters.new(1, [:atomics])
        while :counters.get(cnt, 1) < 10 do
          :counters.add(cnt, 1, 1)
        end

        IO.puts("Current value is \#{:counters.get(cnt, 1)}")
      end
    ```

    For changing local variables there is a reduce like variant with two parameters:
    ```
      result = while <varname>, <expression> do
        <loop>
      end
    ```
    the difference is that you can use the <varname> both in the expression
    and the loop. The returned value of the loop will become the next <varname>.
    Example:

    ```

      def demo_local() do
        cnt = 1
        cnt = while_with cnt, cnt < 10 do
          cnt + 1
        end

        IO.puts("Current value is \#{cnt}")
      end
    ```

  """
  defmacro while_with(name, clause, do: expression) do
    quote do
      while_with_impl(
        fn unquote(name) -> unquote(clause) end,
        fn unquote(name) -> unquote(expression) end,
        unquote(name)
      )
    end
  end

  defmacro while(clause, do: expression) do
    quote do
      while_impl(fn -> unquote(clause) end, fn -> unquote(expression) end)
    end
  end

  def while_impl(predicate, body) do
    if predicate.() do
      body.()
      while_impl(predicate, body)
    end
  end

  def while_with_impl(predicate, body, value) do
    if predicate.(value) do
      while_with_impl(predicate, body, body.(value))
    else
      value
    end
  end
end

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
      while <varname>, <expression> do
        <loop>
      end
    ```
    the difference is that you can use the <varname> both in the expression
    and the loop.
    Example:

    ```

      def demo_local() do
        cnt = 1
        cnt = while cnt, cnt < 10 do
          cnt + 1
        end

        IO.puts("Current value is \#{cnt}")
      end
    ```

  """

  @doc """
      while_with binds the first parameter into clause and
      expression. The result is also assigned to the given
      variable name. It's a shorthand for while loops:

      ```
      cnt = 1
      while_with cnt, cnt < 10 do
        cnt + 1
      end
      ```

  """
  defmacro while_with(name, clause, do: expression) do
    quote do
      unquote(name) =
        while_with_impl(
          fn unquote(name) -> unquote(clause) end,
          fn unquote(name) -> unquote(expression) end,
          unquote(name)
        )
    end
  end

  @doc """
    while/2 executes the expression until the clause returns false
    ```
    cnt = :counters.new(1, [:atomics])
    while :counters.get(cnt, 1) < 10 do
      :counters.add(cnt, 1, 1)
    end
    ```
  """
  defmacro while(clause, do: expression) do
    quote do
      while_impl(fn -> unquote(clause) end, fn -> unquote(expression) end)
    end
  end

  @doc """
    while/3 executes the expression until the clause returns false.
    It takes a name parameter first for a variable that it puts into context
    of clause and expression. The result needs to be assigned.
    ```
    cnt = 1
    cnt = while cnt, cnt < 10 do
      cnt + 1
    end
    ```
  """
  defmacro while(name, clause, do: expression) do
    quote do
      while_with_impl(
        fn unquote(name) -> unquote(clause) end,
        fn unquote(name) -> unquote(expression) end,
        unquote(name)
      )
    end
  end

  @doc false
  def while_impl(predicate, body) do
    if predicate.() do
      body.()
      while_impl(predicate, body)
    end
  end

  @doc false
  def while_with_impl(predicate, body, value) do
    if predicate.(value) do
      while_with_impl(predicate, body, body.(value))
    else
      value
    end
  end

  @doc """
    reduce_while is an explicit while implementation, that
    follows the Enum.reduce_while/3 pattern.
    ```
      i = reduce_while(1, fn i ->
        if i < 10 do
          {:continue, i + 1}
        else
          {:halt, i}
        end
      end)
    ```
  """
  def reduce_while(acc, fun) do
    case fun.(acc) do
      {:halt, new} -> new
      {:continue, new} -> reduce_while(new, fun)
    end
  end
end

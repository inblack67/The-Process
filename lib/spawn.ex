defmodule Proc.Spawn do
  def greet, do: :hello

  def start do
    pid =
      spawn(fn ->
        IO.inspect(greet())

        receive do
          message -> IO.inspect(message)
        after
          5000 -> IO.puts("timeout")
        end
      end)

    send(pid, "hacked")
  end

  def main do
    send(self(), "yayy")

    receive do
      message -> IO.inspect(message)
    after
      5000 -> IO.puts("timeout")
    end
  end
end

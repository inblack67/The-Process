defmodule Proc.Tasks2 do
  def heavy_lifting(arg) do
    {:ok, pid} = Task.start_link(fn -> do_heavy_lifting(arg) end)
    pid
  end

  defp do_heavy_lifting(arg) do
    parent = self()

    Task.start_link(fn ->
      Process.sleep(5000)
      IO.puts("heavy lifted #{arg}")
      send(parent, :done)
    end)

    receive do
      :done ->
        IO.puts("done heavy lifting with arg #{arg}")
    end
  end
end

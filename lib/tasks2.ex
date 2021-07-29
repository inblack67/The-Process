defmodule Proc.Tasks2 do
  def heavy_lifting(arg) do
    # unique ref (snapshot) => date & time & pid
    ref = make_ref()
    source = self()
    {:ok, pid} = Task.start_link(fn -> do_heavy_lifting(source, arg, ref) end)

    receive do
      # accepting receives from the process which has our unique ref => do_heavy_lifting
      {:ok, ^ref, message} ->
        IO.puts(message)

      10000 ->
        IO.puts("timout")
    end

    pid
  end

  defp do_heavy_lifting(source, arg, ref) do
    parent = self()

    Task.start_link(fn ->
      Process.sleep(5000)
      IO.puts("heavy lifted #{arg}")
      send(parent, :done)
    end)

    receive do
      :done ->
        send(source, {:ok, ref, "done heavy lifting with arg #{arg}"})

      10000 ->
        IO.puts("timout")
    end
  end
end

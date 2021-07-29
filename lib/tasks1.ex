defmodule Proc.Tasks1 do
  # tasks returns :ok tuple => unlike spawn

  def chained_boundaries do
    {:ok, pid} =
      Task.start_link(fn ->
        download_internet()
      end)

    pid
  end

  def download_internet do
    parent = self()

    # downloads the internet
    Task.start_link(fn ->
      Process.sleep(5000)
      IO.puts("downloaded the internet")
      send(parent, :done)
    end)

    # reports
    Task.start_link(fn ->
      raise "error downloading the internet"
      IO.puts("report => internet downloading started")
    end)

    receive do
      :done ->
        IO.puts("done with the internet downloading")
    end
  end

  def heavy_lifting(arg) do
    # start_link => merge the failure domains so that blast radius can be minimized => in this case if it crashes => iex shell will not be restarted => it's pid does not change => unlike in case of start => the error would reach till the iex shell

    # if iex shell crashes then start_link would also make this task crash so no response will be printed after 500ms but if we use start => then failure domains would be different and even if console iex shell crashes and restarts => task will continue on

    # kill process =>
    # Process.exit(self(), :kill)

    {:ok, pid} =
      Task.start_link(fn ->
        do_heavy_lifting(arg)
      end)

    # start => just run
    # {:ok, pid} =
    #   Task.start(fn ->
    #     do_heavy_lifting(arg)
    #   end)

    pid
  end

  defp do_heavy_lifting(arg) do
    # raise "error"
    Process.sleep(5000)
    IO.puts("heavy lifted #{arg}")
    47
  end

  def main do
    # will return {:ok, _pid}
    Task.start(fn ->
      Process.sleep(500)
      IO.puts("hello")
      47
    end)
  end
end

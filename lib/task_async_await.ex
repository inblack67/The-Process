defmodule Proc.Task3 do
  def heavy_lifting(arg) do
    # this is what async task looks like
    # %Task{
    #   owner: #PID<0.158.0>,
    #   pid: #PID<0.160.0>,
    #   ref: #Reference<0.703254542.504627204.202309>
    # }
    # Task.async subscribe to a notifcation so that if the process dies which was about to take ten minutes but died after 2 min, you dont wanna be hanging around for 10 min
    task = Task.async(fn -> do_heavy_lifting(arg) end)

    IO.inspect(task)

    Task.await(task)

    IO.puts("hello")
  end

  defp do_heavy_lifting(arg) do
    Process.sleep(5000)
    IO.puts("heavy lifted #{arg}")
    :done
  end
end

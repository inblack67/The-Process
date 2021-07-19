# The Elixir Processes

## iex & spawn

- **flush** => only works in a shell => prints out all the messages in the process message queue and then deletes them all from the queue
- **v** => gives the prev result in the console
- **Process.alive?(pid)**
- **pid** would still be valid even if the process dies so => check via **Process.alive?/1**
- VM does not give a way to find out what lies in the process dictionary of one process, from the another
- **Process.put(key, value)**
- **Process.get(key)**
- **Process.get/1** => get all the process values
- Keep process dictionary immutable

## Tasks

- Just like **spawn** but use **task**
- Elixir & Erlang are failure domain driven languages

### start_link

- VM has blast radius => default is 1. The only thing that fails is the failure itself (current process which lead to the failure)
- Panic and restarts => **kubernetes?**
- Limit the blast radius

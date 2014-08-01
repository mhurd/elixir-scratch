defmodule Tick do
    @interval 2000
    @name :ticker
    
    def start do
        pid = spawn(__MODULE__, :generator, [[]])
        :global.register_name(@name, pid)
    end

    def stop do
        send :global.whereis_name(@name), {:stop}
    end

    def register(client_pid) do
        send :global.whereis_name(@name), {:register, client_pid} 
    end

    def generator(clients) do
        receive do
            {:stop} ->
                Enum.each clients, fn client -> 
                    send client, {:stop} end
                IO.puts "#{@name} stopping..."
                exit(0)
            {:register, pid} -> 
                IO.puts "registering #{inspect pid}"
                generator([pid|clients])
        after
            @interval -> 
                IO.puts "tick"
                Enum.each clients, fn client ->
                    send client, {:tick}
                end
                generator(clients)
        end
    end
end

defmodule Client do

    def start do
        pid = spawn(__MODULE__, :receiver, [])
        Tick.register(pid)
    end

    def receiver do
        receive do
            {:stop} ->
                IO.puts "#{Node.self} stopping..."
                exit(0)
            {:tick} ->
                IO.puts "tock in client: #{Node.self}"
                receiver
        end
    end

end
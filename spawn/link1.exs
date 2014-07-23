import :timer, only: [ sleep: 1 ]

defmodule Link1 do
    def sad_function do
        sleep 500
        exit(99)
    end
    
    def run do
        spawn(Link1, :sad_function, [])
        receive do
            msg -> IO.puts "MESSAGE RECEIVED: #{inspect msg}"
        after 1000 -> IO.puts "Nothing happened as far as I'm concerned"
        end
    end
    
end

Link1.run
defmodule Spawn2 do
    def greet do
        receive do
            {sender, msg} -> send sender, {:ok, "Hello #{msg}"}
        end
    end
end

# here's the client

pid = spawn(Spawn2, :greet, [])
send pid, {self, "World!"}

receive do
    {:ok, message} -> IO.puts message
end

send pid, {self, "Kermit!"}
receive do
    {:ok, message} -> IO.puts message
end

# Hangs forever because our greet function only handles a single message. 
#Once it has processed the receive , it exits. As a result, the second message 
# we send it is never processed. The second receive at the top level then just 
# hangs, waiting for a response that will never come. 
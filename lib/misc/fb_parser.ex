defmodule Misc.FbParser do

    def parse(%{"message" => message, "sender" => sender}) do
        IO.puts "handle: message"
        IO.inspect message
        IO.inspect sender

        m = judge_cmd message, sender["id"]
        IO.inspect m
    end

    def judge_cmd(%{"quick_reply" => %{"payload" => cmd}, "text" => text}, sender_id) do
        IO.puts "quick reply"
        IO.inspect cmd
        IO.inspect text
        {cmd, text, sender_id}
    end

    def judge_cmd(%{"text" => text}, sender_id) do
        IO.puts "text message"
        [cmd|message] = String.split(text, ~r{ |　})
        case Enum.join(message, " ") do
            "" ->
                {cmd, cmd, sender_id}
            _ ->
                {cmd, Enum.join(message, " "), sender_id}
        end
    end

    def parse(message) do
        IO.puts "else"
        IO.inspect message
        {:err, "unknown", ""}
    end
end

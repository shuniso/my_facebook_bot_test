defmodule Misc.FbFactory do

    def construct(cmd, text, id) do
        Poison.encode! %{
            "recipient": %{"id": id},
            "message": %{
                #"text": Misc.Zen.get,
                "text": "test",
                "quick_replies": [
                    %{
                        "content_type": "text",
                        "title": "test",
                        "payload": "TEST"
                    },
                    %{
                        "content_type": "text",
                        "title": "test2",
                        "payload": "TEST2"
                    }
                ]
            }
        }
    end

end

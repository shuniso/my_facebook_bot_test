defmodule Misc.Trello do

    def get do
        [
            %{
                "content_type": "text",
                "title": "redux学ぶ",
                "payload": "TRELLO" <> "1"
            },
            %{
                "content_type": "text",
                "title": "Ecto試す",
                "payload": "TRELLO" <> "2"
            },
            %{
                "content_type": "text",
                "title": "Phoenix起動まで",
                "payload": "TRELLO" <> "3"
            },
            %{
                "content_type": "text",
                "title": "仕様読む",
                "payload": "TRELLO" <> "4"
            },
            %{
                "content_type": "text",
                "title": "やっぱやめる",
                "payload": "WHY"
            }
        ]

    end

    defp process_get_response(%{status_code: 200, body: body}) do
        #body
        #|> IO.inspect
    end

    defp process_get_response(res = %{status_code: _}) do
        #IO.puts "response_err"
        #IO.inspect res
    end

end

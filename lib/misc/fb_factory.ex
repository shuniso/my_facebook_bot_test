defmodule Misc.FbFactory do

    def handle(cmd, text, id) do
        handle_cmd(cmd, text, id)
    end
    def handle_cmd("zen", text, id) do
        IO.puts "cmd=zen"
        Misc.Zen.get
        |> construct(id)
    end

    def handle_cmd("NEW", text, id) do
        construct("どれをやりますか？", get_list, id)
    end
    def handle_cmd("TIMEUP", text, id) do
        construct("時間だよ。🍅　終わった？", is_end, id)
    end
    def handle_cmd("UNTILL", text, id) do
        construct("そうですか。仕方ないですね。 X)", continue, id)
    end
    def handle_cmd("REST", text, id) do
        construct("おつかれさま〜 :)", id)
    end
    def handle_cmd("MORE", text, id) do
        construct("がんばれ！", id)
    end
    def handle_cmd("COMPLETE", text, id) do
        construct("GOOD JOB !! :)", go_to_next, id)
    end
    def handle_cmd("WHY", text, id) do
        construct("なにしにきた", id)
    end

    def handle_cmd(cmd, text, id) do
        case String.starts_with?(cmd, "TRELLO") do
          true ->
              construct("ではスタート。がんばってください。🍅単位でお知らせします。", id)
          false ->
              construct("始める？", resp, id)
        end
    end


    def start_task() do

    end

    def construct(text, id) do
        Poison.encode! %{
            "recipient": %{"id": id},
            "message": %{
                "text": text,
            }
        }
    end

    def construct(text, replies, id) do
        Poison.encode! %{
            "recipient": %{"id": id},
            "message": %{
                "text": text,
                "quick_replies": replies
            }
        }
    end

    def get_list() do
        Misc.Trello.get
    end

    def resp() do
        [
            %{
                "content_type": "text",
                "title": "タスクを選ぶ",
                "payload": "NEW"
            },
            %{
                "content_type": "text",
                "title": "なんでもない",
                "payload": "WHY"
            }
        ]
    end

    # TIMEUP
    def is_end() do
        [
            %{
                "content_type": "text",
                "title": "終わった",
                "payload": "COMPLETE"
            },
            %{
                "content_type": "text",
                "title": "まだ",
                "payload": "UNTILL"
            }
        ]
    end
    # UNTILL
    def continue() do
        [
            %{
                "content_type": "text",
                "title": "まだやる",
                "payload": "MORE"
            },
            %{
                "content_type": "text",
                "title": "別のやる",
                "payload": "NEW"
            }
        ]
    end
    # COMPLETE
    def go_to_next() do
        [
            %{
                "content_type": "text",
                "title": "次行く",
                "payload": "NEW"
            },
            %{
                "content_type": "text",
                "title": "やすむ",
                "payload": "REST"
            }
        ]
    end
end

defmodule Fbot.MessageController do
  use Fbot.Web, :controller

  alias Fbot.Message

  plug :scrub_params, "entry" when action in [:create, :update]

  def index(conn, params) do
    # facebook verification challenge
    IO.inspect params
    IO.inspect params["hub.verify_token"]
    if params["hub.verify_token"] == System.get_env "FBOT_SECRET_KEYBASE" do
        IO.inspect "verify challenge success"
        send_resp(conn, 200, params["hub.challenge"])
    end
    #messages = Repo.all(Message)
    messages = %{}
    IO.inspect messages
    render(conn, "index.json", messages: messages)
  end

  def create(conn, %{"entry" => messages, "object" => object}) do

    # changeset = Message.changeset(%Message{}, message_params)

    IO.inspect messages
    IO.inspect object
    token = System.get_env("FB_BOT_TOKEN")
    url = "https://graph.facebook.com/v2.6/me/messages?access_token=" <> token

    Enum.each(messages,
      fn(ms) ->
        Enum.each(ms["messaging"],
          fn(m) ->
            IO.inspect m
            json = cond do
              m["message"] -> Poison.encode! %{
                  "recipient": %{"id": m["sender"]["id"]},
                  "message": cond do
                      m["message"]["attachments"] -> %{"attachment": List.first m["message"]["attachments"]}
                      m["message"]["text"] ->
                          IO.inspect m["message"]["text"]
                          %{"text": m["message"]["text"]}
                      true -> nil
                  end
                }
              true -> nil
            end
            IO.inspect json
          if json != nil do
              response = HTTPoison.request!(:post, url, json,
                [
                  {"Content-Type", "application/json; charset=UTF-8"}
                ]
              )
            else
              IO.inspect  "from bot ? do not handle this "
            end
          end
        )
      end
    )
    send_resp(conn, 200, "")

    '''
    case Repo.insert(changeset) do
      {:ok, message} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", message_path(conn, :show, message))
        |> render("show.json", message: message)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Fbot.ChangesetView, "error.json", changeset: changeset)
    end
    '''
  end

  def show(conn, %{"id" => id}) do
    message = Repo.get!(Message, id)
    render(conn, "show.json", message: message)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Repo.get!(Message, id)
    changeset = Message.changeset(message, message_params)

    case Repo.update(changeset) do
      {:ok, message} ->
        render(conn, "show.json", message: message)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Fbot.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Repo.get!(Message, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(message)

    send_resp(conn, :no_content, "")
  end
end

defmodule Misc.Msg do

    defp get_url do
        Application.get_env(:fbot, :fb_url) <> Application.get_env(:fbot, :fb_token)
    end

    def post(json) do
        IO.inspect json
        get_url
        |> HTTPoison.post!(json, [
          {"Content-Type", "application/json; charset=UTF-8"}])
        |> process_get_response
    end

    defp process_get_response(%{status_code: 200, body: body}) do
        body
        |> IO.inspect
    end

    defp process_get_response(res = %{status_code: _}) do
        IO.puts "response_err"
        IO.inspect res
    end

end

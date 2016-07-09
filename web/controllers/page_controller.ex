defmodule Fbot.PageController do
  use Fbot.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

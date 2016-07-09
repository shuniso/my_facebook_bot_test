defmodule Fbot.MessageView do
  use Fbot.Web, :view

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, Fbot.MessageView, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, Fbot.MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      m: message.m}
  end
end

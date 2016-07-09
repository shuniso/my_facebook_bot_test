defmodule FbotAction.Supervisor do
'''
  def start_link(opts \\ []) do
    Task.Supervisor.start_link(opts)
  end

  def start_action(supervisor, command, trigger, message, sender_id) do
    IO.puts "start_action"
    # Slackのプロセスから呼ばれ、このSupervisor配下に新しいプロセスを作成する。
    # Task.Supervisorの子プロセスの戦略は `simple_one_for_one` になり、動的に追加できる。
    # クラッシュ時は再起動されない
    Task.Supervisor.start_child(supervisor, fn ->
      IO.puts "start_child"
      case command do
        :respond -> FbotAction.Action.respond(trigger, message, sender_id)
        :hear -> FbotAction.Action.hear(trigger, message, sender_id)
        :direct ->
          FbotAction.Action.direct(trigger, message, sender_id)
          FbotAction.Action.hear(trigger, message, sender_id)
      end
    end)
  end
'''
end

ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Fbot.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Fbot.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Fbot.Repo)


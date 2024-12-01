alias Bloc.Accounts.User

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bloc.Repo.insert!(%Bloc.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

%{
  email: "evan.sorenson.9@gmail.com",
  role: :admin,
  password: "Bloc12345678"
}
|> then(&User.registration_changeset(%User{}, &1))
|> Bloc.Repo.insert!()

defmodule Bloc.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Bloc.Repo

  alias Bloc.Accounts.User

  def user_factory(attrs) do
    %{
      email: sequence(:email, &"email-#{&1}@example.com"),
      role: :user,
      password: valid_user_password()
    }
    |> merge_attributes(attrs)
    |> then(&User.registration_changeset(%User{}, &1))
    |> Ecto.Changeset.apply_changes()
  end

  def block_factory do
    %Bloc.Blocks.Block{
      title: sequence(:title, &"title-#{&1}"),
      start_time: DateTime.utc_now(),
      end_time: DateTime.utc_now() |> DateTime.add(1, :hour),
      user: build(:user)
    }
  end

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end

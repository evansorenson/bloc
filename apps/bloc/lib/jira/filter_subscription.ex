defmodule Jira.FilterSubscription do
  @moduledoc """
  Provides struct and type for a FilterSubscription
  """

  @type t :: %__MODULE__{
          group: Jira.FilterSubscriptionGroup.t() | nil,
          id: integer | nil,
          user: Jira.FilterSubscriptionUser.t() | nil
        }

  defstruct [:group, :id, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      group: {Jira.FilterSubscriptionGroup, :t},
      id: :integer,
      user: {Jira.FilterSubscriptionUser, :t}
    ]
  end
end

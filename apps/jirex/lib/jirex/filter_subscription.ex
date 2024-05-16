defmodule Jirex.FilterSubscription do
  @moduledoc """
  Provides struct and type for a FilterSubscription
  """

  @type t :: %__MODULE__{
          group: Jirex.FilterSubscriptionGroup.t() | nil,
          id: integer | nil,
          user: Jirex.FilterSubscriptionUser.t() | nil
        }

  defstruct [:group, :id, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      group: {Jirex.FilterSubscriptionGroup, :t},
      id: :integer,
      user: {Jirex.FilterSubscriptionUser, :t}
    ]
  end
end

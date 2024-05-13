defmodule Jira.Group do
  @moduledoc """
  Provides struct and type for a Group
  """

  @type t :: %__MODULE__{
          expand: String.t() | nil,
          groupId: String.t() | nil,
          name: String.t() | nil,
          self: String.t() | nil,
          users: Jira.GroupUsers.t() | nil
        }

  defstruct [:expand, :groupId, :name, :self, :users]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      expand: {:string, :generic},
      groupId: {:string, :generic},
      name: {:string, :generic},
      self: {:string, :uri},
      users: {Jira.GroupUsers, :t}
    ]
  end
end

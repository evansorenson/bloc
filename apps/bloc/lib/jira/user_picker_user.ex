defmodule Jira.UserPickerUser do
  @moduledoc """
  Provides struct and type for a UserPickerUser
  """

  @type t :: %__MODULE__{
          accountId: String.t() | nil,
          avatarUrl: String.t() | nil,
          displayName: String.t() | nil,
          html: String.t() | nil,
          key: String.t() | nil,
          name: String.t() | nil
        }

  defstruct [:accountId, :avatarUrl, :displayName, :html, :key, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accountId: {:string, :generic},
      avatarUrl: {:string, :uri},
      displayName: {:string, :generic},
      html: {:string, :generic},
      key: {:string, :generic},
      name: {:string, :generic}
    ]
  end
end

defmodule Jirex.WorklogUpdateAuthor do
  @moduledoc """
  Provides struct and type for a WorklogUpdateAuthor
  """

  @type t :: %__MODULE__{
          accountId: String.t() | nil,
          accountType: String.t() | nil,
          active: boolean | nil,
          avatarUrls: map | nil,
          displayName: String.t() | nil,
          emailAddress: String.t() | nil,
          key: String.t() | nil,
          name: String.t() | nil,
          self: String.t() | nil,
          timeZone: String.t() | nil
        }

  defstruct [
    :accountId,
    :accountType,
    :active,
    :avatarUrls,
    :displayName,
    :emailAddress,
    :key,
    :name,
    :self,
    :timeZone
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accountId: {:string, :generic},
      accountType: {:string, :generic},
      active: :boolean,
      avatarUrls: :map,
      displayName: {:string, :generic},
      emailAddress: {:string, :generic},
      key: {:string, :generic},
      name: {:string, :generic},
      self: {:string, :generic},
      timeZone: {:string, :generic}
    ]
  end
end

defmodule Jirex.FoundUsers do
  @moduledoc """
  Provides struct and type for a FoundUsers
  """

  @type t :: %__MODULE__{
          header: String.t() | nil,
          total: integer | nil,
          users: [Jirex.UserPickerUser.t()] | nil
        }

  defstruct [:header, :total, :users]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [header: {:string, :generic}, total: :integer, users: [{Jirex.UserPickerUser, :t}]]
  end
end

defmodule Jira.StatusCategory do
  @moduledoc """
  Provides struct and type for a StatusCategory
  """

  @type t :: %__MODULE__{
          colorName: String.t() | nil,
          id: integer | nil,
          key: String.t() | nil,
          name: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [:colorName, :id, :key, :name, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      colorName: {:string, :generic},
      id: :integer,
      key: {:string, :generic},
      name: {:string, :generic},
      self: {:string, :generic}
    ]
  end
end

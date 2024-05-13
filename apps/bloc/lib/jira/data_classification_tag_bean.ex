defmodule Jira.DataClassificationTagBean do
  @moduledoc """
  Provides struct and type for a DataClassificationTagBean
  """

  @type t :: %__MODULE__{
          color: String.t() | nil,
          description: String.t() | nil,
          guideline: String.t() | nil,
          id: String.t(),
          name: String.t() | nil,
          rank: integer | nil,
          status: String.t()
        }

  defstruct [:color, :description, :guideline, :id, :name, :rank, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      color: {:string, :generic},
      description: {:string, :generic},
      guideline: {:string, :generic},
      id: {:string, :generic},
      name: {:string, :generic},
      rank: :integer,
      status: {:string, :generic}
    ]
  end
end

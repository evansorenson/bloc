defmodule Jira.StatusCreate do
  @moduledoc """
  Provides struct and type for a StatusCreate
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          name: String.t(),
          statusCategory: String.t()
        }

  defstruct [:description, :name, :statusCategory]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      name: {:string, :generic},
      statusCategory: {:enum, ["TODO", "IN_PROGRESS", "DONE"]}
    ]
  end
end

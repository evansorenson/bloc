defmodule Jirex.CreateCustomFieldContext do
  @moduledoc """
  Provides struct and type for a CreateCustomFieldContext
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: String.t() | nil,
          issueTypeIds: [String.t()] | nil,
          name: String.t(),
          projectIds: [String.t()] | nil
        }

  defstruct [:description, :id, :issueTypeIds, :name, :projectIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: {:string, :generic},
      issueTypeIds: [string: :generic],
      name: {:string, :generic},
      projectIds: [string: :generic]
    ]
  end
end

defmodule Jirex.CustomFieldContext do
  @moduledoc """
  Provides struct and type for a CustomFieldContext
  """

  @type t :: %__MODULE__{
          description: String.t(),
          id: String.t(),
          isAnyIssueType: boolean,
          isGlobalContext: boolean,
          name: String.t()
        }

  defstruct [:description, :id, :isAnyIssueType, :isGlobalContext, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: {:string, :generic},
      isAnyIssueType: :boolean,
      isGlobalContext: :boolean,
      name: {:string, :generic}
    ]
  end
end

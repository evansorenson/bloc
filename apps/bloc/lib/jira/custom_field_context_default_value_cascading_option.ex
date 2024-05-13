defmodule Jira.CustomFieldContextDefaultValueCascadingOption do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueCascadingOption
  """

  @type t :: %__MODULE__{
          cascadingOptionId: String.t() | nil,
          contextId: String.t(),
          optionId: String.t(),
          type: String.t()
        }

  defstruct [:cascadingOptionId, :contextId, :optionId, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cascadingOptionId: {:string, :generic},
      contextId: {:string, :generic},
      optionId: {:string, :generic},
      type: {:string, :generic}
    ]
  end
end

defmodule Jira.CustomFieldContextOption do
  @moduledoc """
  Provides struct and type for a CustomFieldContextOption
  """

  @type t :: %__MODULE__{
          disabled: boolean,
          id: String.t(),
          optionId: String.t() | nil,
          value: String.t()
        }

  defstruct [:disabled, :id, :optionId, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      disabled: :boolean,
      id: {:string, :generic},
      optionId: {:string, :generic},
      value: {:string, :generic}
    ]
  end
end

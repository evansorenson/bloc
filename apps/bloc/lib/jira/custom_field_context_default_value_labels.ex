defmodule Jira.CustomFieldContextDefaultValueLabels do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueLabels
  """

  @type t :: %__MODULE__{labels: [String.t()], type: String.t()}

  defstruct [:labels, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [labels: [string: :generic], type: {:string, :generic}]
  end
end

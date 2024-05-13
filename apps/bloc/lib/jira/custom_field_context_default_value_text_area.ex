defmodule Jira.CustomFieldContextDefaultValueTextArea do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueTextArea
  """

  @type t :: %__MODULE__{text: String.t() | nil, type: String.t()}

  defstruct [:text, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [text: {:string, :generic}, type: {:string, :generic}]
  end
end

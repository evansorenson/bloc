defmodule Jira.IssueContextVariable do
  @moduledoc """
  Provides struct and type for a IssueContextVariable
  """

  @type t :: %__MODULE__{id: integer | nil, key: String.t() | nil, type: String.t()}

  defstruct [:id, :key, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, key: {:string, :generic}, type: {:string, :generic}]
  end
end

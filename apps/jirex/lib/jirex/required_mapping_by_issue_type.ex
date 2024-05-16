defmodule Jirex.RequiredMappingByIssueType do
  @moduledoc """
  Provides struct and type for a RequiredMappingByIssueType
  """

  @type t :: %__MODULE__{issueTypeId: String.t() | nil, statusIds: [String.t()] | nil}

  defstruct [:issueTypeId, :statusIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueTypeId: {:string, :generic}, statusIds: [string: :generic]]
  end
end

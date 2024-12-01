defmodule Jirex.IssueTypeScreenSchemeItem do
  @moduledoc """
  Provides struct and type for a IssueTypeScreenSchemeItem
  """

  @type t :: %__MODULE__{
          issueTypeId: String.t(),
          issueTypeScreenSchemeId: String.t(),
          screenSchemeId: String.t()
        }

  defstruct [:issueTypeId, :issueTypeScreenSchemeId, :screenSchemeId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      issueTypeId: {:string, :generic},
      issueTypeScreenSchemeId: {:string, :generic},
      screenSchemeId: {:string, :generic}
    ]
  end
end

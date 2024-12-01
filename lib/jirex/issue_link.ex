defmodule Jirex.IssueLink do
  @moduledoc """
  Provides struct and type for a IssueLink
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          inwardIssue: Jirex.IssueLinkInwardIssue.t(),
          outwardIssue: Jirex.IssueLinkOutwardIssue.t(),
          self: String.t() | nil,
          type: Jirex.IssueLinkType.t()
        }

  defstruct [:id, :inwardIssue, :outwardIssue, :self, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: {:string, :generic},
      inwardIssue: {Jirex.IssueLinkInwardIssue, :t},
      outwardIssue: {Jirex.IssueLinkOutwardIssue, :t},
      self: {:string, :uri},
      type: {Jirex.IssueLinkType, :t}
    ]
  end
end

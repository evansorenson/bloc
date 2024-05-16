defmodule Jirex.LinkIssueRequestJsonBean do
  @moduledoc """
  Provides struct and type for a LinkIssueRequestJsonBean
  """

  @type t :: %__MODULE__{
          comment: Jirex.Comment.t() | nil,
          inwardIssue: Jirex.LinkedIssue.t(),
          outwardIssue: Jirex.LinkedIssue.t(),
          type: Jirex.IssueLinkType.t()
        }

  defstruct [:comment, :inwardIssue, :outwardIssue, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      comment: {Jirex.Comment, :t},
      inwardIssue: {Jirex.LinkedIssue, :t},
      outwardIssue: {Jirex.LinkedIssue, :t},
      type: {Jirex.IssueLinkType, :t}
    ]
  end
end

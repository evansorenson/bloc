defmodule Jirex.IssueTypeSchemeDetails do
  @moduledoc """
  Provides struct and type for a IssueTypeSchemeDetails
  """

  @type t :: %__MODULE__{
          defaultIssueTypeId: String.t() | nil,
          description: String.t() | nil,
          issueTypeIds: [String.t()],
          name: String.t()
        }

  defstruct [:defaultIssueTypeId, :description, :issueTypeIds, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultIssueTypeId: {:string, :generic},
      description: {:string, :generic},
      issueTypeIds: [string: :generic],
      name: {:string, :generic}
    ]
  end
end

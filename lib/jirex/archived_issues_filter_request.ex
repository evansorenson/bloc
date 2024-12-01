defmodule Jirex.ArchivedIssuesFilterRequest do
  @moduledoc """
  Provides struct and type for a ArchivedIssuesFilterRequest
  """

  @type t :: %__MODULE__{
          archivedBy: [String.t()] | nil,
          archivedDateRange: Jirex.DateRangeFilterRequest.t() | nil,
          issueTypes: [String.t()] | nil,
          projects: [String.t()] | nil,
          reporters: [String.t()] | nil
        }

  defstruct [:archivedBy, :archivedDateRange, :issueTypes, :projects, :reporters]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      archivedBy: [string: :generic],
      archivedDateRange: {Jirex.DateRangeFilterRequest, :t},
      issueTypes: [string: :generic],
      projects: [string: :generic],
      reporters: [string: :generic]
    ]
  end
end

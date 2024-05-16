defmodule Jirex.Version do
  @moduledoc """
  Provides struct and type for a Version
  """

  @type t :: %__MODULE__{
          approvers: [Jirex.VersionApprover.t()] | nil,
          archived: boolean | nil,
          description: String.t() | nil,
          driver: String.t() | nil,
          expand: String.t() | nil,
          id: String.t() | nil,
          issuesStatusForFixVersion: Jirex.VersionIssuesStatusForFixVersion.t() | nil,
          moveUnfixedIssuesTo: String.t() | nil,
          name: String.t() | nil,
          operations: [Jirex.SimpleLink.t()] | nil,
          overdue: boolean | nil,
          project: String.t() | nil,
          projectId: integer | nil,
          releaseDate: Date.t() | nil,
          released: boolean | nil,
          self: String.t() | nil,
          startDate: Date.t() | nil,
          userReleaseDate: String.t() | nil,
          userStartDate: String.t() | nil
        }

  defstruct [
    :approvers,
    :archived,
    :description,
    :driver,
    :expand,
    :id,
    :issuesStatusForFixVersion,
    :moveUnfixedIssuesTo,
    :name,
    :operations,
    :overdue,
    :project,
    :projectId,
    :releaseDate,
    :released,
    :self,
    :startDate,
    :userReleaseDate,
    :userStartDate
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      approvers: [{Jirex.VersionApprover, :t}],
      archived: :boolean,
      description: {:string, :generic},
      driver: {:string, :generic},
      expand: {:string, :generic},
      id: {:string, :generic},
      issuesStatusForFixVersion: {Jirex.VersionIssuesStatusForFixVersion, :t},
      moveUnfixedIssuesTo: {:string, :uri},
      name: {:string, :generic},
      operations: [{Jirex.SimpleLink, :t}],
      overdue: :boolean,
      project: {:string, :generic},
      projectId: :integer,
      releaseDate: {:string, :date},
      released: :boolean,
      self: {:string, :uri},
      startDate: {:string, :date},
      userReleaseDate: {:string, :generic},
      userStartDate: {:string, :generic}
    ]
  end
end

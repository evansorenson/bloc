defmodule Jirex.Errors do
  @moduledoc """
  Provides struct and type for a Errors
  """

  @type t :: %__MODULE__{
          issueIsSubtask: Jirex.Error.t() | nil,
          issuesInArchivedProjects: Jirex.Error.t() | nil,
          issuesInUnlicensedProjects: Jirex.Error.t() | nil,
          issuesNotFound: Jirex.Error.t() | nil
        }

  defstruct [
    :issueIsSubtask,
    :issuesInArchivedProjects,
    :issuesInUnlicensedProjects,
    :issuesNotFound
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      issueIsSubtask: {Jirex.Error, :t},
      issuesInArchivedProjects: {Jirex.Error, :t},
      issuesInUnlicensedProjects: {Jirex.Error, :t},
      issuesNotFound: {Jirex.Error, :t}
    ]
  end
end

defmodule Jira.ProjectRoleActorsUpdateBean do
  @moduledoc """
  Provides struct and type for a ProjectRoleActorsUpdateBean
  """

  @type t :: %__MODULE__{
          categorisedActors: Jira.ProjectRoleActorsUpdateBeanCategorisedActors.t() | nil,
          id: integer | nil
        }

  defstruct [:categorisedActors, :id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [categorisedActors: {Jira.ProjectRoleActorsUpdateBeanCategorisedActors, :t}, id: :integer]
  end
end

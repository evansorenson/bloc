defmodule Jira.ContainerOfWorkflowSchemeAssociations do
  @moduledoc """
  Provides struct and type for a ContainerOfWorkflowSchemeAssociations
  """

  @type t :: %__MODULE__{values: [Jira.WorkflowSchemeAssociations.t()]}

  defstruct [:values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [values: [{Jira.WorkflowSchemeAssociations, :t}]]
  end
end

defmodule Jira.DefaultWorkflow do
  @moduledoc """
  Provides struct and type for a DefaultWorkflow
  """

  @type t :: %__MODULE__{updateDraftIfNeeded: boolean | nil, workflow: String.t()}

  defstruct [:updateDraftIfNeeded, :workflow]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [updateDraftIfNeeded: :boolean, workflow: {:string, :generic}]
  end
end

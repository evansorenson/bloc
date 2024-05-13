defmodule Jira.CustomFieldContextProjectMapping do
  @moduledoc """
  Provides struct and type for a CustomFieldContextProjectMapping
  """

  @type t :: %__MODULE__{
          contextId: String.t(),
          isGlobalContext: boolean | nil,
          projectId: String.t() | nil
        }

  defstruct [:contextId, :isGlobalContext, :projectId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contextId: {:string, :generic}, isGlobalContext: :boolean, projectId: {:string, :generic}]
  end
end

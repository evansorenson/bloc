defmodule Jira.BulkEditShareableEntityResponse do
  @moduledoc """
  Provides struct and type for a BulkEditShareableEntityResponse
  """

  @type t :: %__MODULE__{
          action: String.t(),
          entityErrors: Jira.BulkEditShareableEntityResponseEntityErrors.t() | nil
        }

  defstruct [:action, :entityErrors]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      action: {:enum, ["changeOwner", "changePermission", "addPermission", "removePermission"]},
      entityErrors: {Jira.BulkEditShareableEntityResponseEntityErrors, :t}
    ]
  end
end

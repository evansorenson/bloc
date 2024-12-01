defmodule Jirex.StatusesPerWorkflow do
  @moduledoc """
  Provides struct and type for a StatusesPerWorkflow
  """

  @type t :: %__MODULE__{
          initialStatusId: String.t() | nil,
          statuses: [String.t()] | nil,
          workflowId: String.t() | nil
        }

  defstruct [:initialStatusId, :statuses, :workflowId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      initialStatusId: {:string, :generic},
      statuses: [string: :generic],
      workflowId: {:string, :generic}
    ]
  end
end

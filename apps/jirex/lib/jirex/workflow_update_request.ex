defmodule Jirex.WorkflowUpdateRequest do
  @moduledoc """
  Provides struct and type for a WorkflowUpdateRequest
  """

  @type t :: %__MODULE__{
          statuses: [Jirex.WorkflowStatusUpdate.t()],
          workflows: [Jirex.WorkflowUpdate.t()]
        }

  defstruct [:statuses, :workflows]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [statuses: [{Jirex.WorkflowStatusUpdate, :t}], workflows: [{Jirex.WorkflowUpdate, :t}]]
  end
end

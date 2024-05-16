defmodule Jirex.WorkflowValidationError do
  @moduledoc """
  Provides struct and type for a WorkflowValidationError
  """

  @type t :: %__MODULE__{
          code: String.t() | nil,
          elementReference: Jirex.WorkflowElementReference.t() | nil,
          level: String.t() | nil,
          message: String.t() | nil,
          type: String.t() | nil
        }

  defstruct [:code, :elementReference, :level, :message, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      code: {:string, :generic},
      elementReference: {Jirex.WorkflowElementReference, :t},
      level: {:enum, ["WARNING", "ERROR"]},
      message: {:string, :generic},
      type:
        {:enum,
         [
           "RULE",
           "STATUS",
           "STATUS_LAYOUT",
           "STATUS_PROPERTY",
           "WORKFLOW",
           "TRANSITION",
           "TRANSITION_PROPERTY",
           "SCOPE",
           "STATUS_MAPPING",
           "TRIGGER"
         ]}
    ]
  end
end

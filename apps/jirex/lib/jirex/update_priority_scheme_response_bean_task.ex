defmodule Jirex.UpdatePrioritySchemeResponseBeanTask do
  @moduledoc """
  Provides struct and type for a UpdatePrioritySchemeResponseBeanTask
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          elapsedRuntime: integer | nil,
          finished: integer | nil,
          id: String.t() | nil,
          lastUpdate: integer | nil,
          message: String.t() | nil,
          progress: integer | nil,
          result: map | nil,
          self: String.t() | nil,
          started: integer | nil,
          status: String.t() | nil,
          submitted: integer | nil,
          submittedBy: integer | nil
        }

  defstruct [
    :description,
    :elapsedRuntime,
    :finished,
    :id,
    :lastUpdate,
    :message,
    :progress,
    :result,
    :self,
    :started,
    :status,
    :submitted,
    :submittedBy
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      elapsedRuntime: :integer,
      finished: :integer,
      id: {:string, :generic},
      lastUpdate: :integer,
      message: {:string, :generic},
      progress: :integer,
      result: :map,
      self: {:string, :uri},
      started: :integer,
      status:
        {:enum,
         ["ENQUEUED", "RUNNING", "COMPLETE", "FAILED", "CANCEL_REQUESTED", "CANCELLED", "DEAD"]},
      submitted: :integer,
      submittedBy: :integer
    ]
  end
end

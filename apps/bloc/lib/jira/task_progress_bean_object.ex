defmodule Jira.TaskProgressBeanObject do
  @moduledoc """
  Provides struct and type for a TaskProgressBeanObject
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          elapsedRuntime: integer,
          finished: integer | nil,
          id: String.t(),
          lastUpdate: integer,
          message: String.t() | nil,
          progress: integer,
          result: map | nil,
          self: String.t(),
          started: integer | nil,
          status: String.t(),
          submitted: integer,
          submittedBy: integer
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

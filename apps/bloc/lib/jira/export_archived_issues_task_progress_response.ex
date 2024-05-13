defmodule Jira.ExportArchivedIssuesTaskProgressResponse do
  @moduledoc """
  Provides struct and type for a ExportArchivedIssuesTaskProgressResponse
  """

  @type t :: %__MODULE__{
          fileUrl: String.t() | nil,
          payload: String.t() | nil,
          progress: integer | nil,
          status: String.t() | nil,
          submittedTime: DateTime.t() | nil,
          taskId: String.t() | nil
        }

  defstruct [:fileUrl, :payload, :progress, :status, :submittedTime, :taskId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      fileUrl: {:string, :generic},
      payload: {:string, :generic},
      progress: :integer,
      status: {:string, :generic},
      submittedTime: {:string, :date_time},
      taskId: {:string, :generic}
    ]
  end
end

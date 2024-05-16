defmodule Jirex.IssueUpdateDetails do
  @moduledoc """
  Provides struct and type for a IssueUpdateDetails
  """

  @type t :: %__MODULE__{
          fields: Jirex.IssueUpdateDetailsFields.t() | nil,
          historyMetadata: Jirex.IssueUpdateDetailsHistoryMetadata.t() | nil,
          properties: [Jirex.EntityProperty.t()] | nil,
          transition: Jirex.IssueUpdateDetailsTransition.t() | nil,
          update: Jirex.IssueUpdateDetailsUpdate.t() | nil
        }

  defstruct [:fields, :historyMetadata, :properties, :transition, :update]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      fields: {Jirex.IssueUpdateDetailsFields, :t},
      historyMetadata: {Jirex.IssueUpdateDetailsHistoryMetadata, :t},
      properties: [{Jirex.EntityProperty, :t}],
      transition: {Jirex.IssueUpdateDetailsTransition, :t},
      update: {Jirex.IssueUpdateDetailsUpdate, :t}
    ]
  end
end

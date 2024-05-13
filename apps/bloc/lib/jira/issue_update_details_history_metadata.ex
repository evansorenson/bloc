defmodule Jira.IssueUpdateDetailsHistoryMetadata do
  @moduledoc """
  Provides struct and type for a IssueUpdateDetailsHistoryMetadata
  """

  @type t :: %__MODULE__{
          activityDescription: String.t() | nil,
          activityDescriptionKey: String.t() | nil,
          actor: map | nil,
          cause: map | nil,
          description: String.t() | nil,
          descriptionKey: String.t() | nil,
          emailDescription: String.t() | nil,
          emailDescriptionKey: String.t() | nil,
          extraData: map | nil,
          generator: map | nil,
          type: String.t() | nil
        }

  defstruct [
    :activityDescription,
    :activityDescriptionKey,
    :actor,
    :cause,
    :description,
    :descriptionKey,
    :emailDescription,
    :emailDescriptionKey,
    :extraData,
    :generator,
    :type
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      activityDescription: {:string, :generic},
      activityDescriptionKey: {:string, :generic},
      actor: :map,
      cause: :map,
      description: {:string, :generic},
      descriptionKey: {:string, :generic},
      emailDescription: {:string, :generic},
      emailDescriptionKey: {:string, :generic},
      extraData: :map,
      generator: :map,
      type: {:string, :generic}
    ]
  end
end

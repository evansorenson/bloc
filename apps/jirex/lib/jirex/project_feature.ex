defmodule Jirex.ProjectFeature do
  @moduledoc """
  Provides struct and type for a ProjectFeature
  """

  @type t :: %__MODULE__{
          feature: String.t() | nil,
          imageUri: String.t() | nil,
          localisedDescription: String.t() | nil,
          localisedName: String.t() | nil,
          prerequisites: [String.t()] | nil,
          projectId: integer | nil,
          state: String.t() | nil,
          toggleLocked: boolean | nil
        }

  defstruct [
    :feature,
    :imageUri,
    :localisedDescription,
    :localisedName,
    :prerequisites,
    :projectId,
    :state,
    :toggleLocked
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      feature: {:string, :generic},
      imageUri: {:string, :generic},
      localisedDescription: {:string, :generic},
      localisedName: {:string, :generic},
      prerequisites: [string: :generic],
      projectId: :integer,
      state: {:enum, ["ENABLED", "DISABLED", "COMING_SOON"]},
      toggleLocked: :boolean
    ]
  end
end

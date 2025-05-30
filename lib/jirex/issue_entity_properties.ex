defmodule Jirex.IssueEntityProperties do
  @moduledoc """
  Provides struct and type for a IssueEntityProperties
  """

  @type t :: %__MODULE__{
          entitiesIds: [integer] | nil,
          properties: Jirex.IssueEntityPropertiesProperties.t() | nil
        }

  defstruct [:entitiesIds, :properties]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [entitiesIds: [:integer], properties: {Jirex.IssueEntityPropertiesProperties, :t}]
  end
end

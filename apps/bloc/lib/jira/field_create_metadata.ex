defmodule Jira.FieldCreateMetadata do
  @moduledoc """
  Provides struct and type for a FieldCreateMetadata
  """

  @type t :: %__MODULE__{
          allowedValues: [map] | nil,
          autoCompleteUrl: String.t() | nil,
          configuration: Jira.FieldCreateMetadataConfiguration.t() | nil,
          defaultValue: map | nil,
          fieldId: String.t(),
          hasDefaultValue: boolean | nil,
          key: String.t(),
          name: String.t(),
          operations: [String.t()],
          required: boolean,
          schema: Jira.FieldCreateMetadataSchema.t()
        }

  defstruct [
    :allowedValues,
    :autoCompleteUrl,
    :configuration,
    :defaultValue,
    :fieldId,
    :hasDefaultValue,
    :key,
    :name,
    :operations,
    :required,
    :schema
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allowedValues: [:map],
      autoCompleteUrl: {:string, :generic},
      configuration: {Jira.FieldCreateMetadataConfiguration, :t},
      defaultValue: :map,
      fieldId: {:string, :generic},
      hasDefaultValue: :boolean,
      key: {:string, :generic},
      name: {:string, :generic},
      operations: [string: :generic],
      required: :boolean,
      schema: {Jira.FieldCreateMetadataSchema, :t}
    ]
  end
end

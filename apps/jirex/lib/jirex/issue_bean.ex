defmodule Jirex.IssueBean do
  @moduledoc """
  Provides struct and type for a IssueBean
  """

  @type t :: %__MODULE__{
          changelog: Jirex.IssueBeanChangelog.t() | nil,
          editmeta: Jirex.IssueBeanEditmeta.t() | nil,
          expand: String.t() | nil,
          fields: %{String.t() => any()} | nil,
          fieldsToInclude: Jirex.IncludedFields.t() | nil,
          id: String.t() | nil,
          key: String.t() | nil,
          names: Jirex.IssueBeanNames.t() | nil,
          operations: Jirex.IssueBeanOperations.t() | nil,
          properties: Jirex.IssueBeanProperties.t() | nil,
          renderedFields: Jirex.IssueBeanRenderedFields.t() | nil,
          schema: Jirex.IssueBeanSchema.t() | nil,
          self: String.t() | nil,
          transitions: [Jirex.IssueTransition.t()] | nil,
          versionedRepresentations: Jirex.IssueBeanVersionedRepresentations.t() | nil
        }

  defstruct [
    :changelog,
    :editmeta,
    :expand,
    :fields,
    :fieldsToInclude,
    :id,
    :key,
    :names,
    :operations,
    :properties,
    :renderedFields,
    :schema,
    :self,
    :transitions,
    :versionedRepresentations
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      changelog: {Jirex.IssueBeanChangelog, :t},
      editmeta: {Jirex.IssueBeanEditmeta, :t},
      expand: {:string, :generic},
      fields: {:map, {:string, :any}},
      fieldsToInclude: {Jirex.IncludedFields, :t},
      id: {:string, :generic},
      key: {:string, :generic},
      names: {Jirex.IssueBeanNames, :t},
      operations: {Jirex.IssueBeanOperations, :t},
      properties: {Jirex.IssueBeanProperties, :t},
      renderedFields: {Jirex.IssueBeanRenderedFields, :t},
      schema: {Jirex.IssueBeanSchema, :t},
      self: {:string, :uri},
      transitions: [{Jirex.IssueTransition, :t}],
      versionedRepresentations: {Jirex.IssueBeanVersionedRepresentations, :t}
    ]
  end
end

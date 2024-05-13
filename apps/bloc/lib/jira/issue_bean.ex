defmodule Jira.IssueBean do
  @moduledoc """
  Provides struct and type for a IssueBean
  """

  @type t :: %__MODULE__{
          changelog: Jira.IssueBeanChangelog.t() | nil,
          editmeta: Jira.IssueBeanEditmeta.t() | nil,
          expand: String.t() | nil,
          fields: Jira.IssueBeanFields.t() | nil,
          fieldsToInclude: Jira.IncludedFields.t() | nil,
          id: String.t() | nil,
          key: String.t() | nil,
          names: Jira.IssueBeanNames.t() | nil,
          operations: Jira.IssueBeanOperations.t() | nil,
          properties: Jira.IssueBeanProperties.t() | nil,
          renderedFields: Jira.IssueBeanRenderedFields.t() | nil,
          schema: Jira.IssueBeanSchema.t() | nil,
          self: String.t() | nil,
          transitions: [Jira.IssueTransition.t()] | nil,
          versionedRepresentations: Jira.IssueBeanVersionedRepresentations.t() | nil
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
      changelog: {Jira.IssueBeanChangelog, :t},
      editmeta: {Jira.IssueBeanEditmeta, :t},
      expand: {:string, :generic},
      fields: {Jira.IssueBeanFields, :t},
      fieldsToInclude: {Jira.IncludedFields, :t},
      id: {:string, :generic},
      key: {:string, :generic},
      names: {Jira.IssueBeanNames, :t},
      operations: {Jira.IssueBeanOperations, :t},
      properties: {Jira.IssueBeanProperties, :t},
      renderedFields: {Jira.IssueBeanRenderedFields, :t},
      schema: {Jira.IssueBeanSchema, :t},
      self: {:string, :uri},
      transitions: [{Jira.IssueTransition, :t}],
      versionedRepresentations: {Jira.IssueBeanVersionedRepresentations, :t}
    ]
  end
end

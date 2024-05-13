defmodule Jira.SearchRequestBean do
  @moduledoc """
  Provides struct and type for a SearchRequestBean
  """

  @type t :: %__MODULE__{
          expand: [String.t()] | nil,
          fields: [String.t()] | nil,
          fieldsByKeys: boolean | nil,
          jql: String.t() | nil,
          maxResults: integer | nil,
          properties: [String.t()] | nil,
          startAt: integer | nil,
          validateQuery: String.t() | nil
        }

  defstruct [
    :expand,
    :fields,
    :fieldsByKeys,
    :jql,
    :maxResults,
    :properties,
    :startAt,
    :validateQuery
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      expand: [string: :generic],
      fields: [string: :generic],
      fieldsByKeys: :boolean,
      jql: {:string, :generic},
      maxResults: :integer,
      properties: [string: :generic],
      startAt: :integer,
      validateQuery: {:enum, ["strict", "warn", "none", "true", "false"]}
    ]
  end
end

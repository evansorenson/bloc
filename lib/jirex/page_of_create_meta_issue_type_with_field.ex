defmodule Jirex.PageOfCreateMetaIssueTypeWithField do
  @moduledoc """
  Provides struct and type for a PageOfCreateMetaIssueTypeWithField
  """

  @type t :: %__MODULE__{
          fields: [Jirex.FieldCreateMetadata.t()] | nil,
          maxResults: integer | nil,
          results: [Jirex.FieldCreateMetadata.t()] | nil,
          startAt: integer | nil,
          total: integer | nil
        }

  defstruct [:fields, :maxResults, :results, :startAt, :total]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      fields: [{Jirex.FieldCreateMetadata, :t}],
      maxResults: :integer,
      results: [{Jirex.FieldCreateMetadata, :t}],
      startAt: :integer,
      total: :integer
    ]
  end
end

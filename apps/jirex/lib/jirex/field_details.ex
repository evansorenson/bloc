defmodule Jirex.FieldDetails do
  @moduledoc """
  Provides struct and type for a FieldDetails
  """

  @type t :: %__MODULE__{
          clauseNames: [String.t()] | nil,
          custom: boolean | nil,
          id: String.t() | nil,
          key: String.t() | nil,
          name: String.t() | nil,
          navigable: boolean | nil,
          orderable: boolean | nil,
          schema: map | nil,
          scope: map | nil,
          searchable: boolean | nil
        }

  defstruct [
    :clauseNames,
    :custom,
    :id,
    :key,
    :name,
    :navigable,
    :orderable,
    :schema,
    :scope,
    :searchable
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      clauseNames: [string: :generic],
      custom: :boolean,
      id: {:string, :generic},
      key: {:string, :generic},
      name: {:string, :generic},
      navigable: :boolean,
      orderable: :boolean,
      schema: :map,
      scope: :map,
      searchable: :boolean
    ]
  end
end

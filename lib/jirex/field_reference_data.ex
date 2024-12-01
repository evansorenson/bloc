defmodule Jirex.FieldReferenceData do
  @moduledoc """
  Provides struct and type for a FieldReferenceData
  """

  @type t :: %__MODULE__{
          auto: String.t() | nil,
          cfid: String.t() | nil,
          deprecated: String.t() | nil,
          deprecatedSearcherKey: String.t() | nil,
          displayName: String.t() | nil,
          operators: [String.t()] | nil,
          orderable: String.t() | nil,
          searchable: String.t() | nil,
          types: [String.t()] | nil,
          value: String.t() | nil
        }

  defstruct [
    :auto,
    :cfid,
    :deprecated,
    :deprecatedSearcherKey,
    :displayName,
    :operators,
    :orderable,
    :searchable,
    :types,
    :value
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      auto: {:enum, ["true", "false"]},
      cfid: {:string, :generic},
      deprecated: {:enum, ["true", "false"]},
      deprecatedSearcherKey: {:string, :generic},
      displayName: {:string, :generic},
      operators: [string: :generic],
      orderable: {:enum, ["true", "false"]},
      searchable: {:enum, ["true", "false"]},
      types: [string: :generic],
      value: {:string, :generic}
    ]
  end
end

defmodule Jira.JqlFunctionPrecomputationBean do
  @moduledoc """
  Provides struct and type for a JqlFunctionPrecomputationBean
  """

  @type t :: %__MODULE__{
          arguments: [String.t()] | nil,
          created: DateTime.t() | nil,
          error: String.t() | nil,
          field: String.t() | nil,
          functionKey: String.t() | nil,
          functionName: String.t() | nil,
          id: String.t() | nil,
          operator: String.t() | nil,
          updated: DateTime.t() | nil,
          used: DateTime.t() | nil,
          value: String.t() | nil
        }

  defstruct [
    :arguments,
    :created,
    :error,
    :field,
    :functionKey,
    :functionName,
    :id,
    :operator,
    :updated,
    :used,
    :value
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      arguments: [string: :generic],
      created: {:string, :date_time},
      error: {:string, :generic},
      field: {:string, :generic},
      functionKey: {:string, :generic},
      functionName: {:string, :generic},
      id: {:string, :generic},
      operator: {:string, :generic},
      updated: {:string, :date_time},
      used: {:string, :date_time},
      value: {:string, :generic}
    ]
  end
end

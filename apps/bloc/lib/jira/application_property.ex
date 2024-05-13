defmodule Jira.ApplicationProperty do
  @moduledoc """
  Provides struct and type for a ApplicationProperty
  """

  @type t :: %__MODULE__{
          allowedValues: [String.t()] | nil,
          defaultValue: String.t() | nil,
          desc: String.t() | nil,
          example: String.t() | nil,
          id: String.t() | nil,
          key: String.t() | nil,
          name: String.t() | nil,
          type: String.t() | nil,
          value: String.t() | nil
        }

  defstruct [:allowedValues, :defaultValue, :desc, :example, :id, :key, :name, :type, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allowedValues: [string: :generic],
      defaultValue: {:string, :generic},
      desc: {:string, :generic},
      example: {:string, :generic},
      id: {:string, :generic},
      key: {:string, :generic},
      name: {:string, :generic},
      type: {:string, :generic},
      value: {:string, :generic}
    ]
  end
end

defmodule Jirex.IssueFieldOption do
  @moduledoc """
  Provides struct and type for a IssueFieldOption
  """

  @type t :: %__MODULE__{
          config: Jirex.IssueFieldOptionConfiguration.t() | nil,
          id: integer,
          properties: Jirex.IssueFieldOptionProperties.t() | nil,
          value: String.t()
        }

  defstruct [:config, :id, :properties, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      config: {Jirex.IssueFieldOptionConfiguration, :t},
      id: :integer,
      properties: {Jirex.IssueFieldOptionProperties, :t},
      value: {:string, :generic}
    ]
  end
end

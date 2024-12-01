defmodule Jirex.IssueFieldOptionCreateBean do
  @moduledoc """
  Provides struct and type for a IssueFieldOptionCreateBean
  """

  @type t :: %__MODULE__{
          config: Jirex.IssueFieldOptionConfiguration.t() | nil,
          properties: Jirex.IssueFieldOptionCreateBeanProperties.t() | nil,
          value: String.t()
        }

  defstruct [:config, :properties, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      config: {Jirex.IssueFieldOptionConfiguration, :t},
      properties: {Jirex.IssueFieldOptionCreateBeanProperties, :t},
      value: {:string, :generic}
    ]
  end
end

defmodule Jirex.IssueFieldOptionConfiguration do
  @moduledoc """
  Provides struct and type for a IssueFieldOptionConfiguration
  """

  @type t :: %__MODULE__{
          attributes: [String.t()] | nil,
          scope: Jirex.IssueFieldOptionConfigurationScope.t() | nil
        }

  defstruct [:attributes, :scope]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      attributes: [enum: ["notSelectable", "defaultValue"]],
      scope: {Jirex.IssueFieldOptionConfigurationScope, :t}
    ]
  end
end

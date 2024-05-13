defmodule Jira.IncludedFields do
  @moduledoc """
  Provides struct and type for a IncludedFields
  """

  @type t :: %__MODULE__{
          actuallyIncluded: [String.t()] | nil,
          excluded: [String.t()] | nil,
          included: [String.t()] | nil
        }

  defstruct [:actuallyIncluded, :excluded, :included]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actuallyIncluded: [string: :generic],
      excluded: [string: :generic],
      included: [string: :generic]
    ]
  end
end

defmodule Jirex.FoundGroups do
  @moduledoc """
  Provides struct and type for a FoundGroups
  """

  @type t :: %__MODULE__{
          groups: [Jirex.FoundGroup.t()] | nil,
          header: String.t() | nil,
          total: integer | nil
        }

  defstruct [:groups, :header, :total]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [groups: [{Jirex.FoundGroup, :t}], header: {:string, :generic}, total: :integer]
  end
end

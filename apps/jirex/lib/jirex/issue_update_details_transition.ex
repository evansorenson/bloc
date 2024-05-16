defmodule Jirex.IssueUpdateDetailsTransition do
  @moduledoc """
  Provides struct and type for a IssueUpdateDetailsTransition
  """

  @type t :: %__MODULE__{
          expand: String.t() | nil,
          fields: map | nil,
          hasScreen: boolean | nil,
          id: String.t() | nil,
          isAvailable: boolean | nil,
          isConditional: boolean | nil,
          isGlobal: boolean | nil,
          isInitial: boolean | nil,
          looped: boolean | nil,
          name: String.t() | nil,
          to: map | nil
        }

  defstruct [
    :expand,
    :fields,
    :hasScreen,
    :id,
    :isAvailable,
    :isConditional,
    :isGlobal,
    :isInitial,
    :looped,
    :name,
    :to
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      expand: {:string, :generic},
      fields: :map,
      hasScreen: :boolean,
      id: {:string, :generic},
      isAvailable: :boolean,
      isConditional: :boolean,
      isGlobal: :boolean,
      isInitial: :boolean,
      looped: :boolean,
      name: {:string, :generic},
      to: :map
    ]
  end
end

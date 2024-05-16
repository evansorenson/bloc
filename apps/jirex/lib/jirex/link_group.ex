defmodule Jirex.LinkGroup do
  @moduledoc """
  Provides struct and type for a LinkGroup
  """

  @type t :: %__MODULE__{
          groups: [Jirex.LinkGroup.t()] | nil,
          header: Jirex.SimpleLink.t() | nil,
          id: String.t() | nil,
          links: [Jirex.SimpleLink.t()] | nil,
          styleClass: String.t() | nil,
          weight: integer | nil
        }

  defstruct [:groups, :header, :id, :links, :styleClass, :weight]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      groups: [{Jirex.LinkGroup, :t}],
      header: {Jirex.SimpleLink, :t},
      id: {:string, :generic},
      links: [{Jirex.SimpleLink, :t}],
      styleClass: {:string, :generic},
      weight: :integer
    ]
  end
end

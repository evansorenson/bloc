defmodule Jirex.Watchers do
  @moduledoc """
  Provides struct and type for a Watchers
  """

  @type t :: %__MODULE__{
          isWatching: boolean | nil,
          self: String.t() | nil,
          watchCount: integer | nil,
          watchers: [Jirex.UserDetails.t()] | nil
        }

  defstruct [:isWatching, :self, :watchCount, :watchers]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      isWatching: :boolean,
      self: {:string, :generic},
      watchCount: :integer,
      watchers: [{Jirex.UserDetails, :t}]
    ]
  end
end

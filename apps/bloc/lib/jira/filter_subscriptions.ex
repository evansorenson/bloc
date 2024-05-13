defmodule Jira.FilterSubscriptions do
  @moduledoc """
  Provides struct and type for a FilterSubscriptions
  """

  @type t :: %__MODULE__{
          "end-index": integer | nil,
          items: [Jira.FilterSubscription.t()] | nil,
          "max-results": integer | nil,
          size: integer | nil,
          "start-index": integer | nil
        }

  defstruct [:"end-index", :items, :"max-results", :size, :"start-index"]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      "end-index": :integer,
      items: [{Jira.FilterSubscription, :t}],
      "max-results": :integer,
      size: :integer,
      "start-index": :integer
    ]
  end
end

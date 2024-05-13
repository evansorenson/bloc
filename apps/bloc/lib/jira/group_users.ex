defmodule Jira.GroupUsers do
  @moduledoc """
  Provides struct and type for a GroupUsers
  """

  @type t :: %__MODULE__{
          "end-index": integer | nil,
          items: [Jira.UserDetails.t()] | nil,
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
      items: [{Jira.UserDetails, :t}],
      "max-results": :integer,
      size: :integer,
      "start-index": :integer
    ]
  end
end

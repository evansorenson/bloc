defmodule Jirex.PageOfChangelogs do
  @moduledoc """
  Provides struct and type for a PageOfChangelogs
  """

  @type t :: %__MODULE__{
          histories: [Jirex.Changelog.t()] | nil,
          maxResults: integer | nil,
          startAt: integer | nil,
          total: integer | nil
        }

  defstruct [:histories, :maxResults, :startAt, :total]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [histories: [{Jirex.Changelog, :t}], maxResults: :integer, startAt: :integer, total: :integer]
  end
end

defmodule Jirex.IssueChangelogIds do
  @moduledoc """
  Provides struct and type for a IssueChangelogIds
  """

  @type t :: %__MODULE__{changelogIds: [integer]}

  defstruct [:changelogIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [changelogIds: [:integer]]
  end
end

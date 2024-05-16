defmodule Jirex.VersionIssuesStatusForFixVersion do
  @moduledoc """
  Provides struct and type for a VersionIssuesStatusForFixVersion
  """

  @type t :: %__MODULE__{
          done: integer | nil,
          inProgress: integer | nil,
          toDo: integer | nil,
          unmapped: integer | nil
        }

  defstruct [:done, :inProgress, :toDo, :unmapped]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [done: :integer, inProgress: :integer, toDo: :integer, unmapped: :integer]
  end
end

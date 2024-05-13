defmodule Jira.ProjectIds do
  @moduledoc """
  Provides struct and type for a ProjectIds
  """

  @type t :: %__MODULE__{projectIds: [String.t()]}

  defstruct [:projectIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [projectIds: [string: :generic]]
  end
end

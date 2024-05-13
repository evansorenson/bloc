defmodule Jira.ProjectScopeBean do
  @moduledoc """
  Provides struct and type for a ProjectScopeBean
  """

  @type t :: %__MODULE__{attributes: [String.t()] | nil, id: integer | nil}

  defstruct [:attributes, :id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [attributes: [enum: ["notSelectable", "defaultValue"]], id: :integer]
  end
end

defmodule Jira.UpdatePrioritySchemeRequestBeanProjectsAdd do
  @moduledoc """
  Provides struct and type for a UpdatePrioritySchemeRequestBeanProjectsAdd
  """

  @type t :: %__MODULE__{ids: [integer] | nil}

  defstruct [:ids]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [ids: [:integer]]
  end
end

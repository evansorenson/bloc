defmodule Jira.MultipleCustomFieldValuesUpdateDetails do
  @moduledoc """
  Provides struct and type for a MultipleCustomFieldValuesUpdateDetails
  """

  @type t :: %__MODULE__{updates: [Jira.MultipleCustomFieldValuesUpdate.t()] | nil}

  defstruct [:updates]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [updates: [{Jira.MultipleCustomFieldValuesUpdate, :t}]]
  end
end

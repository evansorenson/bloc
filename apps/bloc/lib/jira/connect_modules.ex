defmodule Jira.ConnectModules do
  @moduledoc """
  Provides struct and type for a ConnectModules
  """

  @type t :: %__MODULE__{modules: [map]}

  defstruct [:modules]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [modules: [:map]]
  end
end

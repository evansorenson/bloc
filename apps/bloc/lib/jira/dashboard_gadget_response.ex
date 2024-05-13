defmodule Jira.DashboardGadgetResponse do
  @moduledoc """
  Provides struct and type for a DashboardGadgetResponse
  """

  @type t :: %__MODULE__{gadgets: [Jira.DashboardGadget.t()]}

  defstruct [:gadgets]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [gadgets: [{Jira.DashboardGadget, :t}]]
  end
end

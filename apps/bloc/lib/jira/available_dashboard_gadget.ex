defmodule Jira.AvailableDashboardGadget do
  @moduledoc """
  Provides struct and type for a AvailableDashboardGadget
  """

  @type t :: %__MODULE__{moduleKey: String.t() | nil, title: String.t(), uri: String.t() | nil}

  defstruct [:moduleKey, :title, :uri]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [moduleKey: {:string, :generic}, title: {:string, :generic}, uri: {:string, :generic}]
  end
end

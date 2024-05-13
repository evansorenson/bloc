defmodule Jira.TimeTrackingProvider do
  @moduledoc """
  Provides struct and type for a TimeTrackingProvider
  """

  @type t :: %__MODULE__{key: String.t(), name: String.t() | nil, url: String.t() | nil}

  defstruct [:key, :name, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [key: {:string, :generic}, name: {:string, :generic}, url: {:string, :generic}]
  end
end

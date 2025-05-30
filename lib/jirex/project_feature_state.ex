defmodule Jirex.ProjectFeatureState do
  @moduledoc """
  Provides struct and type for a ProjectFeatureState
  """

  @type t :: %__MODULE__{state: String.t() | nil}

  defstruct [:state]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [state: {:enum, ["ENABLED", "DISABLED", "COMING_SOON"]}]
  end
end

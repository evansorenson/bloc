defmodule Jirex.ContainerForProjectFeatures do
  @moduledoc """
  Provides struct and type for a ContainerForProjectFeatures
  """

  @type t :: %__MODULE__{features: [Jirex.ProjectFeature.t()] | nil}

  defstruct [:features]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [features: [{Jirex.ProjectFeature, :t}]]
  end
end

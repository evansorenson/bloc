defmodule Jirex.ProjectDataPolicies do
  @moduledoc """
  Provides struct and type for a ProjectDataPolicies
  """

  @type t :: %__MODULE__{projectDataPolicies: [Jirex.ProjectWithDataPolicy.t()] | nil}

  defstruct [:projectDataPolicies]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [projectDataPolicies: [{Jirex.ProjectWithDataPolicy, :t}]]
  end
end

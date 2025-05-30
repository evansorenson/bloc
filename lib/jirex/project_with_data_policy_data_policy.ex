defmodule Jirex.ProjectWithDataPolicyDataPolicy do
  @moduledoc """
  Provides struct and type for a ProjectWithDataPolicyDataPolicy
  """

  @type t :: %__MODULE__{anyContentBlocked: boolean | nil}

  defstruct [:anyContentBlocked]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [anyContentBlocked: :boolean]
  end
end

defmodule Jirex.ProjectWithDataPolicy do
  @moduledoc """
  Provides struct and type for a ProjectWithDataPolicy
  """

  @type t :: %__MODULE__{
          dataPolicy: Jirex.ProjectWithDataPolicyDataPolicy.t() | nil,
          id: integer | nil
        }

  defstruct [:dataPolicy, :id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [dataPolicy: {Jirex.ProjectWithDataPolicyDataPolicy, :t}, id: :integer]
  end
end

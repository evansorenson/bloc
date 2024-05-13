defmodule Jira.LicensedApplication do
  @moduledoc """
  Provides struct and type for a LicensedApplication
  """

  @type t :: %__MODULE__{id: String.t(), plan: String.t()}

  defstruct [:id, :plan]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: {:string, :generic}, plan: {:enum, ["UNLICENSED", "FREE", "PAID"]}]
  end
end

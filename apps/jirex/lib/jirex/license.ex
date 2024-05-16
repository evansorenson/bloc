defmodule Jirex.License do
  @moduledoc """
  Provides struct and type for a License
  """

  @type t :: %__MODULE__{applications: [Jirex.LicensedApplication.t()]}

  defstruct [:applications]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [applications: [{Jirex.LicensedApplication, :t}]]
  end
end

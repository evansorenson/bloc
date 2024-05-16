defmodule Jirex.HealthCheckResult do
  @moduledoc """
  Provides struct and type for a HealthCheckResult
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          name: String.t() | nil,
          passed: boolean | nil
        }

  defstruct [:description, :name, :passed]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [description: {:string, :generic}, name: {:string, :generic}, passed: :boolean]
  end
end

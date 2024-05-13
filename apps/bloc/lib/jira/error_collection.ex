defmodule Jira.ErrorCollection do
  @moduledoc """
  Provides struct and type for a ErrorCollection
  """

  @type t :: %__MODULE__{
          errorMessages: [String.t()] | nil,
          errors: map | nil,
          status: integer | nil
        }

  defstruct [:errorMessages, :errors, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [errorMessages: [string: :generic], errors: :map, status: :integer]
  end
end

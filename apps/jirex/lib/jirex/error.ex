defmodule Jirex.Error do
  @moduledoc """
  Provides struct and type for a Error
  """

  @type t :: %__MODULE__{
          count: integer | nil,
          issueIdsOrKeys: [String.t()] | nil,
          message: String.t() | nil
        }

  defstruct [:count, :issueIdsOrKeys, :message]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [count: :integer, issueIdsOrKeys: [string: :generic], message: {:string, :generic}]
  end
end

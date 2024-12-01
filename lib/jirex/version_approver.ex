defmodule Jirex.VersionApprover do
  @moduledoc """
  Provides struct and type for a VersionApprover
  """

  @type t :: %__MODULE__{
          accountId: String.t() | nil,
          declineReason: String.t() | nil,
          description: String.t() | nil,
          status: String.t() | nil
        }

  defstruct [:accountId, :declineReason, :description, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accountId: {:string, :generic},
      declineReason: {:string, :generic},
      description: {:string, :generic},
      status: {:string, :generic}
    ]
  end
end

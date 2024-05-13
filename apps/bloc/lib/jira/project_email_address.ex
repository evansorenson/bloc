defmodule Jira.ProjectEmailAddress do
  @moduledoc """
  Provides struct and type for a ProjectEmailAddress
  """

  @type t :: %__MODULE__{emailAddress: String.t() | nil, emailAddressStatus: [String.t()] | nil}

  defstruct [:emailAddress, :emailAddressStatus]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [emailAddress: {:string, :generic}, emailAddressStatus: [string: :generic]]
  end
end

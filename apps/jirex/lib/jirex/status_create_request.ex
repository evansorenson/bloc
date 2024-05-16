defmodule Jirex.StatusCreateRequest do
  @moduledoc """
  Provides struct and type for a StatusCreateRequest
  """

  @type t :: %__MODULE__{scope: Jirex.StatusScope.t(), statuses: [Jirex.StatusCreate.t()]}

  defstruct [:scope, :statuses]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [scope: {Jirex.StatusScope, :t}, statuses: [{Jirex.StatusCreate, :t}]]
  end
end

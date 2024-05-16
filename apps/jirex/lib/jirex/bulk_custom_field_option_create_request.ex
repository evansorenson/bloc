defmodule Jirex.BulkCustomFieldOptionCreateRequest do
  @moduledoc """
  Provides struct and type for a BulkCustomFieldOptionCreateRequest
  """

  @type t :: %__MODULE__{options: [Jirex.CustomFieldOptionCreate.t()] | nil}

  defstruct [:options]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [options: [{Jirex.CustomFieldOptionCreate, :t}]]
  end
end

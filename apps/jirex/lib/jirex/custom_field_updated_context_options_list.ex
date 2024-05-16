defmodule Jirex.CustomFieldUpdatedContextOptionsList do
  @moduledoc """
  Provides struct and type for a CustomFieldUpdatedContextOptionsList
  """

  @type t :: %__MODULE__{options: [Jirex.CustomFieldOptionUpdate.t()] | nil}

  defstruct [:options]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [options: [{Jirex.CustomFieldOptionUpdate, :t}]]
  end
end

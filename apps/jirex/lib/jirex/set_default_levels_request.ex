defmodule Jirex.SetDefaultLevelsRequest do
  @moduledoc """
  Provides struct and type for a SetDefaultLevelsRequest
  """

  @type t :: %__MODULE__{defaultValues: [Jirex.DefaultLevelValue.t()]}

  defstruct [:defaultValues]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [defaultValues: [{Jirex.DefaultLevelValue, :t}]]
  end
end

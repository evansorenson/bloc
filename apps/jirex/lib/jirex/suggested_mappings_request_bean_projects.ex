defmodule Jirex.SuggestedMappingsRequestBeanProjects do
  @moduledoc """
  Provides struct and type for a SuggestedMappingsRequestBeanProjects
  """

  @type t :: %__MODULE__{add: [integer] | nil}

  defstruct [:add]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [add: [:integer]]
  end
end

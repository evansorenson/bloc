defmodule Jirex.Locale do
  @moduledoc """
  Provides struct and type for a Locale
  """

  @type t :: %__MODULE__{locale: String.t() | nil}

  defstruct [:locale]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [locale: {:string, :generic}]
  end
end

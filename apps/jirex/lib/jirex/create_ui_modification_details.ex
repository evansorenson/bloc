defmodule Jirex.CreateUiModificationDetails do
  @moduledoc """
  Provides struct and type for a CreateUiModificationDetails
  """

  @type t :: %__MODULE__{
          contexts: [Jirex.UiModificationContextDetails.t()] | nil,
          data: String.t() | nil,
          description: String.t() | nil,
          name: String.t()
        }

  defstruct [:contexts, :data, :description, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      contexts: [{Jirex.UiModificationContextDetails, :t}],
      data: {:string, :generic},
      description: {:string, :generic},
      name: {:string, :generic}
    ]
  end
end

defmodule Jira.ContextualConfiguration do
  @moduledoc """
  Provides struct and type for a ContextualConfiguration
  """

  @type t :: %__MODULE__{
          configuration: map | nil,
          fieldContextId: String.t(),
          id: String.t(),
          schema: map | nil
        }

  defstruct [:configuration, :fieldContextId, :id, :schema]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      configuration: :map,
      fieldContextId: {:string, :generic},
      id: {:string, :generic},
      schema: :map
    ]
  end
end

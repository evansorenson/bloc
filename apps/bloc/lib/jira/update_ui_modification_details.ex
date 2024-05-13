defmodule Jira.UpdateUiModificationDetails do
  @moduledoc """
  Provides struct and type for a UpdateUiModificationDetails
  """

  @type t :: %__MODULE__{
          contexts: [Jira.UiModificationContextDetails.t()] | nil,
          data: String.t() | nil,
          description: String.t() | nil,
          name: String.t() | nil
        }

  defstruct [:contexts, :data, :description, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      contexts: [{Jira.UiModificationContextDetails, :t}],
      data: {:string, :generic},
      description: {:string, :generic},
      name: {:string, :generic}
    ]
  end
end

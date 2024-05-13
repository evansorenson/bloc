defmodule Jira.SuggestedIssue do
  @moduledoc """
  Provides struct and type for a SuggestedIssue
  """

  @type t :: %__MODULE__{
          id: integer | nil,
          img: String.t() | nil,
          key: String.t() | nil,
          keyHtml: String.t() | nil,
          summary: String.t() | nil,
          summaryText: String.t() | nil
        }

  defstruct [:id, :img, :key, :keyHtml, :summary, :summaryText]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: :integer,
      img: {:string, :generic},
      key: {:string, :generic},
      keyHtml: {:string, :generic},
      summary: {:string, :generic},
      summaryText: {:string, :generic}
    ]
  end
end
